module 0x6120a25eaee1c5da1773c5c51e5c7963e88dd7fffc7197296ada17adc9d5de96::elementals {
    struct ELEMENTALS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ElementNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        element_type: 0x1::string::String,
    }

    struct AvatarNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
    }

    struct InitEvent has copy, drop {
        admin: address,
    }

    struct MintElementEvent has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
        name: 0x1::string::String,
        element_type: 0x1::string::String,
    }

    struct CombiningElementsEvent has copy, drop {
        water_element_id: 0x2::object::ID,
        earth_element_id: 0x2::object::ID,
        fire_element_id: 0x2::object::ID,
        air_element_id: 0x2::object::ID,
        aether_element_id: 0x2::object::ID,
    }

    struct MintAvatarEvent has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
        name: 0x1::string::String,
    }

    fun elements_handling(arg0: vector<ElementNFT>) {
        assert!(0x1::vector::length<ElementNFT>(&arg0) == 5, 0);
        let v0 = vector[b"Aether", b"Air", b"Fire", b"Earth", b"Water"];
        let v1 = &mut arg0;
        let v2 = &mut v0;
        let ElementNFT {
            id            : v3,
            name          : _,
            description   : _,
            image_url     : _,
            thumbnail_url : _,
            project_url   : _,
            creator       : _,
            element_type  : _,
        } = pop_and_validate(v1, v2);
        let v11 = v3;
        let v12 = &mut arg0;
        let v13 = &mut v0;
        let ElementNFT {
            id            : v14,
            name          : _,
            description   : _,
            image_url     : _,
            thumbnail_url : _,
            project_url   : _,
            creator       : _,
            element_type  : _,
        } = pop_and_validate(v12, v13);
        let v22 = v14;
        let v23 = &mut arg0;
        let v24 = &mut v0;
        let ElementNFT {
            id            : v25,
            name          : _,
            description   : _,
            image_url     : _,
            thumbnail_url : _,
            project_url   : _,
            creator       : _,
            element_type  : _,
        } = pop_and_validate(v23, v24);
        let v33 = v25;
        let v34 = &mut arg0;
        let v35 = &mut v0;
        let ElementNFT {
            id            : v36,
            name          : _,
            description   : _,
            image_url     : _,
            thumbnail_url : _,
            project_url   : _,
            creator       : _,
            element_type  : _,
        } = pop_and_validate(v34, v35);
        let v44 = v36;
        let v45 = &mut arg0;
        let v46 = &mut v0;
        let ElementNFT {
            id            : v47,
            name          : _,
            description   : _,
            image_url     : _,
            thumbnail_url : _,
            project_url   : _,
            creator       : _,
            element_type  : _,
        } = pop_and_validate(v45, v46);
        let v55 = v47;
        let v56 = CombiningElementsEvent{
            water_element_id  : 0x2::object::uid_to_inner(&v11),
            earth_element_id  : 0x2::object::uid_to_inner(&v22),
            fire_element_id   : 0x2::object::uid_to_inner(&v33),
            air_element_id    : 0x2::object::uid_to_inner(&v44),
            aether_element_id : 0x2::object::uid_to_inner(&v55),
        };
        0x2::event::emit<CombiningElementsEvent>(v56);
        0x2::object::delete(v11);
        0x2::object::delete(v22);
        0x2::object::delete(v33);
        0x2::object::delete(v44);
        0x2::object::delete(v55);
        0x1::vector::destroy_empty<ElementNFT>(arg0);
        0x1::vector::destroy_empty<vector<u8>>(v0);
    }

    public fun get_avatar_creator(arg0: &AvatarNFT) : &0x1::string::String {
        &arg0.creator
    }

    public fun get_avatar_description(arg0: &AvatarNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_avatar_image_url(arg0: &AvatarNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_avatar_name(arg0: &AvatarNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun get_avatar_project_url(arg0: &AvatarNFT) : &0x1::string::String {
        &arg0.project_url
    }

    public fun get_avatar_thumbnail_url(arg0: &AvatarNFT) : &0x1::string::String {
        &arg0.thumbnail_url
    }

    public fun get_element_creator(arg0: &ElementNFT) : &0x1::string::String {
        &arg0.creator
    }

    public fun get_element_description(arg0: &ElementNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_element_image_url(arg0: &ElementNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_element_name(arg0: &ElementNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun get_element_project_url(arg0: &ElementNFT) : &0x1::string::String {
        &arg0.project_url
    }

    public fun get_element_thumbnail_url(arg0: &ElementNFT) : &0x1::string::String {
        &arg0.thumbnail_url
    }

    public fun get_element_type(arg0: &ElementNFT) : &0x1::string::String {
        &arg0.element_type
    }

    fun init(arg0: ELEMENTALS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ELEMENTALS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"element_type"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{element_type}"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{creator}"));
        let v9 = 0x2::display::new_with_fields<ElementNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<ElementNFT>(&mut v9);
        let v10 = 0x2::display::new_with_fields<AvatarNFT>(&v0, v5, v7, arg1);
        0x2::display::update_version<AvatarNFT>(&mut v10);
        let v11 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v11);
        0x2::transfer::public_transfer<0x2::display::Display<ElementNFT>>(v9, v11);
        0x2::transfer::public_transfer<0x2::display::Display<AvatarNFT>>(v10, v11);
        let v12 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v12, v11);
        let v13 = InitEvent{admin: v11};
        0x2::event::emit<InitEvent>(v13);
    }

    public entry fun mint_avatar(arg0: vector<ElementNFT>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        elements_handling(arg0);
        let v0 = 0x1::string::utf8(b"Avatar: The Master Element");
        let v1 = AvatarNFT{
            id            : 0x2::object::new(arg2),
            name          : v0,
            description   : 0x1::string::utf8(x"5468652041766174617220656d626f646965732074686520706572666563742062616c616e6365206f6620616c6c20656c656d656e74732e2049742067726f756e64732077697468204561727468e28099732073746162696c6974792c20666c6f77732077697468205761746572e28099732061646170746162696c6974792c2069676e6974657320776974682046697265e2809973207472616e73666f726d6174696f6e2c20736f617273207769746820416972e280997320696e74656c6c6563742c20616e6420756e69666965732077697468204574686572e280997320637265617469766520706f74656e7469616c2e205468652041766174617220726570726573656e7473206861726d6f6e792c20696e646976696475616c6974792c20616e642074686520696e746572636f6e6e65637465646e657373206f6620616c6c206578697374656e63652e"),
            image_url     : 0x1::string::utf8(b"https://bafybeihhsj546mz6ejplnc35bixw24ka6e7wwxgdys6phv2r4v3ti66pri.ipfs.w3s.link/avatar.png"),
            thumbnail_url : 0x1::string::utf8(b"https://bafybeihhsj546mz6ejplnc35bixw24ka6e7wwxgdys6phv2r4v3ti66pri.ipfs.w3s.link/avatar%20mini.png"),
            project_url   : 0x1::string::utf8(b"https://www.artfitoken.io/"),
            creator       : 0x2::address::to_string(0x2::tx_context::sender(arg2)),
        };
        let v2 = MintAvatarEvent{
            object_id : 0x2::object::id<AvatarNFT>(&v1),
            recipient : arg1,
            name      : v0,
        };
        0x2::event::emit<MintAvatarEvent>(v2);
        0x2::transfer::public_transfer<AvatarNFT>(v1, arg1);
    }

    public entry fun mint_element(arg0: &AdminCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[b"Aether", b"Air", b"Fire", b"Earth", b"Water"];
        assert!(0x1::vector::contains<vector<u8>>(&v0, 0x1::string::as_bytes(&arg7)), 2);
        let v1 = ElementNFT{
            id            : 0x2::object::new(arg8),
            name          : arg2,
            description   : arg3,
            image_url     : arg4,
            thumbnail_url : arg5,
            project_url   : arg6,
            creator       : 0x2::address::to_string(0x2::tx_context::sender(arg8)),
            element_type  : arg7,
        };
        let v2 = MintElementEvent{
            object_id    : 0x2::object::id<ElementNFT>(&v1),
            recipient    : arg1,
            name         : arg2,
            element_type : arg7,
        };
        0x2::event::emit<MintElementEvent>(v2);
        0x2::transfer::public_transfer<ElementNFT>(v1, arg1);
    }

    fun pop_and_validate(arg0: &mut vector<ElementNFT>, arg1: &mut vector<vector<u8>>) : ElementNFT {
        let v0 = 0x1::vector::pop_back<ElementNFT>(arg0);
        let v1 = 0x1::vector::pop_back<vector<u8>>(arg1);
        assert!(0x1::string::as_bytes(&v0.element_type) == &v1, 1);
        v0
    }

    // decompiled from Move bytecode v6
}

