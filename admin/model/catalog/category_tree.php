<?php
class ModelCatalogCategoryTree extends Model 
    {
    public function getCategories($parent_id=60) 
        {            
		$sql = "select c1.category_id ,c2.name from ".DB_PREFIX."category c1
                        LEFT JOIN ".DB_PREFIX."category_description as c2 ON c2.category_id=c1.category_id
                        WHERE c1.parent_id='".$parent_id."' and c2.language_id='".(int)$this->config->get('config_language_id')."' order by c1.sort_order";
                   
		$query = $this->db->query($sql);
		return $query->rows;
        }
    }        
?>