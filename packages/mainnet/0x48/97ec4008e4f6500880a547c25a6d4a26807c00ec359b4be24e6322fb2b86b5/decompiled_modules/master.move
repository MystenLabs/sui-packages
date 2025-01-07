module 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master {
    struct MASTER has drop {
        dummy_field: bool,
    }

    struct Video has drop {
        dummy_field: bool,
    }

    struct Sound has drop {
        dummy_field: bool,
    }

    struct Master<phantom T0> has store, key {
        id: 0x2::object::UID,
        metadata_ref: 0x2::object::ID,
        title: 0x1::string::String,
        image_url: 0x1::string::String,
        media_url: 0x1::string::String,
        sale_status: u8,
    }

    struct Metadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        master_id: 0x2::object::ID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        media_url: 0x1::string::String,
        hashtags: vector<0x1::string::String>,
        creator_profile_id: 0x2::object::ID,
        royalty_percentage_bp: u16,
        master_metadata_parent: 0x1::option::Option<0x2::object::ID>,
        master_metadata_origin: 0x1::option::Option<0x2::object::ID>,
        expressions: u64,
        revenue_total: u64,
        revenue_available: u64,
        revenue_paid: u64,
        revenue_pending: u64,
        master_exported: bool,
    }

    public fun new<T0: drop>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: 0x2::object::ID, arg7: u16, arg8: 0x1::option::Option<0x2::object::ID>, arg9: 0x1::option::Option<0x2::object::ID>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) : Master<T0> {
        let v0 = 0x2::object::new(arg16);
        let v1 = 0x2::object::new(arg16);
        let v2 = Metadata<T0>{
            id                     : v1,
            master_id              : 0x2::object::uid_to_inner(&v0),
            title                  : arg1,
            description            : arg2,
            image_url              : arg3,
            media_url              : arg4,
            hashtags               : arg5,
            creator_profile_id     : arg6,
            royalty_percentage_bp  : arg7,
            master_metadata_parent : arg8,
            master_metadata_origin : arg9,
            expressions            : arg10,
            revenue_total          : arg11,
            revenue_available      : arg12,
            revenue_paid           : arg13,
            revenue_pending        : arg14,
            master_exported        : false,
        };
        0x2::transfer::public_share_object<Metadata<T0>>(v2);
        Master<T0>{
            id           : v0,
            metadata_ref : 0x2::object::uid_to_inner(&v1),
            title        : arg1,
            image_url    : arg3,
            media_url    : arg4,
            sale_status  : arg15,
        }
    }

    public(friend) fun claim<T0>(arg0: &mut Master<T0>) {
        arg0.sale_status = 4;
    }

    public fun add_hashtag<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg1.hashtags, arg2);
    }

    public fun burn_master<T0: drop>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: Master<T0>) : 0x2::object::ID {
        let Master {
            id           : v0,
            metadata_ref : v1,
            title        : _,
            image_url    : _,
            media_url    : _,
            sale_status  : _,
        } = arg1;
        0x2::object::delete(v0);
        v1
    }

    public fun burn_metadata<T0: drop>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: Metadata<T0>) {
        let Metadata {
            id                     : v0,
            master_id              : _,
            title                  : _,
            description            : _,
            image_url              : _,
            media_url              : _,
            hashtags               : _,
            creator_profile_id     : _,
            royalty_percentage_bp  : _,
            master_metadata_parent : _,
            master_metadata_origin : _,
            expressions            : _,
            revenue_total          : _,
            revenue_available      : _,
            revenue_paid           : _,
            revenue_pending        : _,
            master_exported        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun export<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>) {
        arg1.master_exported = true;
    }

    public fun image_url<T0>(arg0: &Master<T0>) : &0x1::string::String {
        &arg0.image_url
    }

    public fun import<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>) {
        arg1.master_exported = false;
    }

    fun init(arg0: MASTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MASTER>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"medial_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"metadata_ref"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{media_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata_ref}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.recrd.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"RECRD"));
        let v5 = 0x2::display::new_with_fields<Master<Video>>(&v0, v1, v3, arg1);
        0x2::display::update_version<Master<Video>>(&mut v5);
        let v6 = 0x2::display::new_with_fields<Master<Sound>>(&v0, v1, v3, arg1);
        0x2::display::update_version<Master<Sound>>(&mut v6);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"media_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"hashtags"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"creator_profile"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"parent"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"origin"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"expressions"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"creator"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{media_url}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{hashtags}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{creator_profile_id}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{master_metadata_parent}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{master_metadata_origin}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{expressions}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://www.recrd.com/"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"RECRD"));
        let v11 = 0x2::display::new_with_fields<Metadata<Video>>(&v0, v7, v9, arg1);
        0x2::display::update_version<Metadata<Video>>(&mut v11);
        let v12 = 0x2::display::new_with_fields<Metadata<Sound>>(&v0, v7, v9, arg1);
        0x2::display::update_version<Metadata<Sound>>(&mut v12);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Master<Video>>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Master<Sound>>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Metadata<Video>>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Metadata<Sound>>>(v12, 0x2::tx_context::sender(arg1));
    }

    public fun list<T0>(arg0: &mut Master<T0>) {
        assert!(arg0.sale_status != 3, 4);
        assert!(arg0.sale_status != 4, 7);
        arg0.sale_status = 2;
    }

    public fun media_url<T0>(arg0: &Master<T0>) : &0x1::string::String {
        &arg0.media_url
    }

    public fun meta_creator_profile_id<T0>(arg0: &Metadata<T0>) : &0x2::object::ID {
        &arg0.creator_profile_id
    }

    public fun meta_description<T0>(arg0: &Metadata<T0>) : &0x1::string::String {
        &arg0.description
    }

    public fun meta_expressions<T0>(arg0: &Metadata<T0>) : u64 {
        arg0.expressions
    }

    public fun meta_hashtags<T0>(arg0: &Metadata<T0>) : &vector<0x1::string::String> {
        &arg0.hashtags
    }

    public fun meta_image_url<T0>(arg0: &Metadata<T0>) : &0x1::string::String {
        &arg0.image_url
    }

    public fun meta_master_id<T0>(arg0: &Metadata<T0>) : &0x2::object::ID {
        &arg0.master_id
    }

    public fun meta_media_url<T0>(arg0: &Metadata<T0>) : &0x1::string::String {
        &arg0.media_url
    }

    public fun meta_origin<T0>(arg0: &Metadata<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.master_metadata_origin
    }

    public fun meta_parent<T0>(arg0: &Metadata<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.master_metadata_parent
    }

    public fun meta_revenue_available<T0>(arg0: &Metadata<T0>) : u64 {
        arg0.revenue_available
    }

    public fun meta_revenue_paid<T0>(arg0: &Metadata<T0>) : u64 {
        arg0.revenue_paid
    }

    public fun meta_revenue_pending<T0>(arg0: &Metadata<T0>) : u64 {
        arg0.revenue_pending
    }

    public fun meta_revenue_total<T0>(arg0: &Metadata<T0>) : u64 {
        arg0.revenue_total
    }

    public fun meta_royalty_percentage_bp<T0>(arg0: &Metadata<T0>) : u16 {
        arg0.royalty_percentage_bp
    }

    public fun meta_title<T0>(arg0: &Metadata<T0>) : &0x1::string::String {
        &arg0.title
    }

    public fun metadata_ref<T0>(arg0: &Master<T0>) : &0x2::object::ID {
        &arg0.metadata_ref
    }

    public fun remove_hashtag<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: 0x1::string::String) {
        let (v0, v1) = 0x1::vector::index_of<0x1::string::String>(&arg1.hashtags, &arg2);
        assert!(v0, 1);
        0x1::vector::remove<0x1::string::String>(&mut arg1.hashtags, v1);
    }

    public fun sale_status<T0>(arg0: &Master<T0>) : u8 {
        arg0.sale_status
    }

    public fun set_description<T0>(arg0: &Master<T0>, arg1: &mut Metadata<T0>, arg2: 0x1::string::String) {
        assert!(0x2::object::id<Master<T0>>(arg0) == arg1.master_id, 6);
        assert!(arg1.master_exported == false, 9);
        arg1.description = arg2;
    }

    public fun set_expressions<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: u64) {
        arg1.expressions = arg2;
    }

    public fun set_hashtags<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: vector<0x1::string::String>) {
        arg1.hashtags = arg2;
    }

    public fun set_image_url<T0>(arg0: &Master<T0>, arg1: &mut Metadata<T0>, arg2: 0x1::string::String) {
        assert!(0x2::object::id<Master<T0>>(arg0) == arg1.master_id, 6);
        assert!(arg1.master_exported == false, 9);
        arg1.image_url = arg2;
    }

    public fun set_media_url<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: 0x1::string::String) {
        arg1.media_url = arg2;
    }

    public fun set_metadata_origin<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: 0x1::option::Option<0x2::object::ID>) {
        arg1.master_metadata_origin = arg2;
    }

    public fun set_metadata_parent<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: 0x1::option::Option<0x2::object::ID>) {
        arg1.master_metadata_parent = arg2;
    }

    public fun set_revenue_available<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: u64) {
        arg1.revenue_available = arg2;
    }

    public fun set_revenue_paid<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: u64) {
        assert!(arg2 > arg1.revenue_paid, 3);
        arg1.revenue_paid = arg2;
    }

    public fun set_revenue_pending<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: u64) {
        arg1.revenue_pending = arg2;
    }

    public fun set_revenue_total<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: u64) {
        assert!(arg2 > arg1.revenue_total, 2);
        arg1.revenue_total = arg2;
    }

    public fun set_royalty_percentage_bp<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Metadata<T0>, arg2: u16) {
        arg1.royalty_percentage_bp = arg2;
    }

    public fun set_title<T0>(arg0: &Master<T0>, arg1: &mut Metadata<T0>, arg2: 0x1::string::String) {
        assert!(0x2::object::id<Master<T0>>(arg0) == arg1.master_id, 6);
        assert!(arg1.master_exported == false, 9);
        arg1.title = arg2;
    }

    public fun suspend<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Master<T0>) {
        arg1.sale_status = 3;
    }

    public fun sync_image_url<T0>(arg0: &mut Master<T0>, arg1: &Metadata<T0>) {
        assert!(0x2::object::id<Master<T0>>(arg0) == arg1.master_id, 6);
        arg0.image_url = arg1.image_url;
    }

    public fun sync_media_url<T0>(arg0: &mut Master<T0>, arg1: &Metadata<T0>) {
        assert!(0x2::object::id<Master<T0>>(arg0) == arg1.master_id, 6);
        arg0.media_url = arg1.media_url;
    }

    public fun sync_title<T0>(arg0: &mut Master<T0>, arg1: &Metadata<T0>) {
        assert!(0x2::object::id<Master<T0>>(arg0) == arg1.master_id, 6);
        arg0.title = arg1.title;
    }

    public fun title<T0>(arg0: &Master<T0>) : &0x1::string::String {
        &arg0.title
    }

    public fun unlist<T0>(arg0: &mut Master<T0>) {
        assert!(arg0.sale_status != 3, 5);
        assert!(arg0.sale_status != 4, 7);
        arg0.sale_status = 1;
    }

    public fun unsuspend<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Master<T0>) {
        assert!(arg1.sale_status == 3, 8);
        arg1.sale_status = 1;
    }

    public(friend) fun update_sale_status<T0>(arg0: &mut Master<T0>, arg1: u8) {
        arg0.sale_status = arg1;
    }

    // decompiled from Move bytecode v6
}

