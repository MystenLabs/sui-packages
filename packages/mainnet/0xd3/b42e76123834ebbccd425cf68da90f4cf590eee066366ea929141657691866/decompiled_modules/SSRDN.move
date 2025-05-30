module 0xd3b42e76123834ebbccd425cf68da90f4cf590eee066366ea929141657691866::SSRDN {
    struct SSRDN has drop {
        dummy_field: bool,
    }

    struct INIT has key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct SSRN has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
        creator: 0x1::string::String,
        properties: 0x1::string::String,
        origin: 0x1::string::String,
    }

    struct EventNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct EventNFTTransfer has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
        name: 0x1::string::String,
    }

    struct EventNFTBurn has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: SSRN, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = EventNFTTransfer{
            object_id : 0x2::object::uid_to_inner(&arg0.id),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
            name      : arg0.name,
        };
        0x2::event::emit<EventNFTTransfer>(v0);
        0x2::transfer::public_transfer<SSRN>(arg0, arg1);
    }

    public entry fun burn(arg0: SSRN, arg1: &mut 0x2::tx_context::TxContext) {
        let SSRN {
            id          : v0,
            name        : v1,
            description : _,
            url         : _,
            image_url   : _,
            creator     : _,
            properties  : _,
            origin      : _,
        } = arg0;
        let v8 = v0;
        let v9 = EventNFTBurn{
            object_id : 0x2::object::uid_to_inner(&v8),
            owner     : 0x2::tx_context::sender(arg1),
            name      : v1,
        };
        0x2::event::emit<EventNFTBurn>(v9);
        0x2::object::delete(v8);
    }

    public fun creator(arg0: &SSRN) : &0x1::string::String {
        &arg0.creator
    }

    public fun description(arg0: &SSRN) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SSRN) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: SSRDN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<SSRDN>(&arg0), 0);
        let v0 = 0x2::package::claim<SSRDN>(arg0, arg1);
        let v1 = 0x2::display::new<SSRN>(&v0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"properties"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://inno.lumiwavelab.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"LUMIWAVE"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{properties}"));
        0x2::display::add_multiple<SSRN>(&mut v1, v2, v4);
        0x2::display::update_version<SSRN>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<SSRN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = INIT{
            id      : 0x2::object::new(arg1),
            creator : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<INIT>(v6);
    }

    public entry fun mint(arg0: &mut INIT, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.creator, 1);
        let v1 = SSRN{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://inno.lumiwavelab.com"),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            creator     : 0x1::string::utf8(b"LUMIWAVE"),
            properties  : 0x1::string::utf8(b""),
            origin      : arg4,
        };
        let v2 = EventNFTMinted{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<EventNFTMinted>(v2);
        0x2::transfer::public_transfer<SSRN>(v1, v0);
    }

    public fun name(arg0: &SSRN) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut SSRN, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_image_url(arg0: &mut SSRN, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun update_properties(arg0: &mut SSRN, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.properties = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

