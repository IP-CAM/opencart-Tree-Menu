<?php

class ControllerCatalogCategoryTree extends Controller 
    {
    public function index() 
        {
		$this->load->language('catalog/category_tree');
		$this->document->setTitle($this->language->get('heading_title'));
        
        $data['heading_title'] = $this->language->get('heading_title');
        $data['text_list'] = $this->language->get('text_list');
        $data['text_no_results'] = $this->language->get('text_no_results');
        
        $data['categories'] = $this->getCategoryTree(0);
        
        $data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home')."",
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
            );

        	
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/category_tree', 'token=' . $this->session->data['token'], 'SSL')
            );

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');       
        
        
		$data['token']=$this->session->data['token'] ;               
        $this->response->setOutput($this->load->view('catalog/category_tree.tpl', $data));
		}
        
        
    protected function getCategoryTree($parent_id)             
        {
       	$this->load->model('catalog/category_tree');
        return  $this->model_catalog_category_tree->getCategories($parent_id);     
        }
        
    public function getCategory()
        {
        $parent_id=0;
        if (isset($this->request->post['parent_id']))
            {   
            $parent_id=$this->request->post['parent_id'];            
            }  

        $results=$this->getCategoryTree($parent_id);        
       
        foreach ($results as $result) 
            {
            $json['categories'][]=array(
                'category_id'   => $result['category_id'],
                'category_name' => $result['name']
                );
            }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
        }
    }       
?>
