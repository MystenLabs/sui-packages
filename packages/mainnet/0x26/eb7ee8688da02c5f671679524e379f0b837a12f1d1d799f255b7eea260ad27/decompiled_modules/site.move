module 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::site {
    struct Site has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::option::Option<0x1::string::String>,
        image_url: 0x1::option::Option<0x1::string::String>,
        description: 0x1::option::Option<0x1::string::String>,
        project_url: 0x1::option::Option<0x1::string::String>,
        creator: 0x1::option::Option<0x1::string::String>,
    }

    struct Resource has drop, store {
        path: 0x1::string::String,
        headers: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        blob_id: u256,
        blob_hash: u256,
        range: 0x1::option::Option<Range>,
    }

    struct Range has drop, store {
        start: 0x1::option::Option<u64>,
        end: 0x1::option::Option<u64>,
    }

    struct ResourcePath has copy, drop, store {
        path: 0x1::string::String,
    }

    struct Routes has drop, store {
        route_list: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct SITE has drop {
        dummy_field: bool,
    }

    public fun add_header(arg0: &mut Resource, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.headers, arg1, arg2);
    }

    public fun add_resource(arg0: &mut Site, arg1: Resource) {
        0x2::dynamic_field::add<ResourcePath, Resource>(&mut arg0.id, new_path(arg1.path), arg1);
    }

    public fun burn(arg0: Site) {
        0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::events::emit_site_burned(0x2::object::id<Site>(&arg0));
        let Site {
            id          : v0,
            name        : _,
            link        : _,
            image_url   : _,
            description : _,
            project_url : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_routes(arg0: &mut Site) {
        0x2::dynamic_field::add<vector<u8>, Routes>(&mut arg0.id, b"routes", new_routes());
    }

    public fun get_site_creator(arg0: &Site) : 0x1::option::Option<0x1::string::String> {
        arg0.creator
    }

    public fun get_site_description(arg0: &Site) : 0x1::option::Option<0x1::string::String> {
        arg0.description
    }

    public fun get_site_image_url(arg0: &Site) : 0x1::option::Option<0x1::string::String> {
        arg0.image_url
    }

    public fun get_site_link(arg0: &Site) : 0x1::option::Option<0x1::string::String> {
        arg0.link
    }

    public fun get_site_name(arg0: &Site) : 0x1::string::String {
        arg0.name
    }

    public fun get_site_project_url(arg0: &Site) : 0x1::option::Option<0x1::string::String> {
        arg0.project_url
    }

    fun init(arg0: SITE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SITE>(arg0, arg1);
        let v1 = init_site_display(&v0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Site>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init_site_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Site> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::display::new_with_fields<Site>(arg0, v0, v2, arg1);
        0x2::display::update_version<Site>(&mut v4);
        v4
    }

    public fun insert_route(arg0: &mut Site, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(0x2::dynamic_field::exists_<ResourcePath>(&arg0.id, new_path(arg2)), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Routes>(&mut arg0.id, b"routes");
        routes_insert(v0, arg1, arg2);
    }

    public fun move_resource(arg0: &mut Site, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = remove_resource(arg0, arg1);
        v0.path = arg2;
        add_resource(arg0, v0);
    }

    fun new_path(arg0: 0x1::string::String) : ResourcePath {
        ResourcePath{path: arg0}
    }

    public fun new_range(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>) : Range {
        let v0 = 0x1::option::is_some<u64>(&arg0);
        let v1 = 0x1::option::is_some<u64>(&arg1);
        assert!(v0 || v1, 2);
        if (v0 && v1) {
            assert!(*0x1::option::borrow<u64>(&arg1) > *0x1::option::borrow<u64>(&arg0), 1);
        };
        Range{
            start : arg0,
            end   : arg1,
        }
    }

    public fun new_range_option(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>) : 0x1::option::Option<Range> {
        if (0x1::option::is_none<u64>(&arg0) && 0x1::option::is_none<u64>(&arg1)) {
            return 0x1::option::none<Range>()
        };
        0x1::option::some<Range>(new_range(arg0, arg1))
    }

    public fun new_resource(arg0: 0x1::string::String, arg1: u256, arg2: u256, arg3: 0x1::option::Option<Range>) : Resource {
        Resource{
            path      : arg0,
            headers   : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            blob_id   : arg1,
            blob_hash : arg2,
            range     : arg3,
        }
    }

    fun new_routes() : Routes {
        Routes{route_list: 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()}
    }

    public fun new_site(arg0: 0x1::string::String, arg1: 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::Metadata, arg2: &mut 0x2::tx_context::TxContext) : Site {
        let v0 = Site{
            id          : 0x2::object::new(arg2),
            name        : arg0,
            link        : 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::link(&arg1),
            image_url   : 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::image_url(&arg1),
            description : 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::description(&arg1),
            project_url : 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::project_url(&arg1),
            creator     : 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::creator(&arg1),
        };
        0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::events::emit_site_created(0x2::object::id<Site>(&v0));
        v0
    }

    public fun remove_all_routes_if_exist(arg0: &mut Site) : 0x1::option::Option<Routes> {
        0x2::dynamic_field::remove_if_exists<vector<u8>, Routes>(&mut arg0.id, b"routes")
    }

    public fun remove_resource(arg0: &mut Site, arg1: 0x1::string::String) : Resource {
        0x2::dynamic_field::remove<ResourcePath, Resource>(&mut arg0.id, new_path(arg1))
    }

    public fun remove_resource_if_exists(arg0: &mut Site, arg1: 0x1::string::String) : 0x1::option::Option<Resource> {
        0x2::dynamic_field::remove_if_exists<ResourcePath, Resource>(&mut arg0.id, new_path(arg1))
    }

    public fun remove_route(arg0: &mut Site, arg1: &0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Routes>(&mut arg0.id, b"routes");
        routes_remove(v0, arg1)
    }

    fun routes_insert(arg0: &mut Routes, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.route_list, arg1, arg2);
    }

    fun routes_remove(arg0: &mut Routes, arg1: &0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.route_list, arg1)
    }

    public fun update_metadata(arg0: &mut Site, arg1: 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::Metadata) {
        arg0.link = 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::link(&arg1);
        arg0.image_url = 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::image_url(&arg1);
        arg0.description = 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::description(&arg1);
        arg0.project_url = 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::project_url(&arg1);
        arg0.creator = 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::metadata::creator(&arg1);
    }

    public fun update_name(arg0: &mut Site, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

