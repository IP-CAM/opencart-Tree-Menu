<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
    
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-tree"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-category">
          <div class="table-responsive">             
			<?php if ($categories) { ?>
            <ul>
            <?php foreach ($categories as $category) { ?>               
				<li><div id="<?php echo $category['category_id']?>" class="categoryTreeToggle">+</div><?php echo $category['name']; ?></li>
                <ul id="subc_<?php echo $category['category_id']?>"></ul>

			<?php } ?>
            </ul>  
            <?php } else { ?>
            <?php echo $text_no_results; ?>
            <?php } ?>          
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript"><!--
$('.table-responsive').on('click','.categoryTreeToggle', function() 
    {
    var parent_id= $(this).attr('id'); 
    if ($("#subc_"+ parent_id).children().length>0)
        {
        $(this).text("+");
        $("#subc_"+ parent_id).children().remove();
        exit;
        }

    $.ajax({
        url			: 'index.php?route=catalog/category_tree/getCategory&token=<?php echo $token; ?>',                
		type		: 'post',
		data		: 'parent_id=' + $(this).attr('id'),
		dataType	: 'json',
		beforeSend	: function() {
				},
		complete: function() { 
				},
		success: function(json) 
				{      
				if (json && json != '') 
					{
					for (i = 0; i < json['categories'].length; i++) 
						{                     
						$("#subc_"+ parent_id).append('<li><div id="'+json['categories'][i]['category_id']+'" class="categoryTreeToggle" >+</div> '
                        +json['categories'][i]['category_name']+'</li>');
						$("#subc_"+ parent_id).append('<ul id="subc_'+json['categories'][i]['category_id']+'"></ul>');
						}
					$("#"+parent_id).text("-");
					}		
				}
			});
	});
//--></script>