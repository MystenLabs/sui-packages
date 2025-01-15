module 0x84c01a1246782bb7b7dd15a506a207482f5863ec113ddd017808cd0f3571a880::elementals {
    struct ELEMENTALS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
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

    struct AdminAddedEvent has copy, drop {
        admin: address,
    }

    struct AdminRemovedEvent has copy, drop {
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

    public entry fun add_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 3);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        let v1 = AdminAddedEvent{admin: arg1};
        0x2::event::emit<AdminAddedEvent>(v1);
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
        let v12 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v12, v11);
        let v13 = AdminRegistry{
            id     : 0x2::object::new(arg1),
            admins : v12,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v11);
        0x2::transfer::public_transfer<0x2::display::Display<ElementNFT>>(v9, v11);
        0x2::transfer::public_transfer<0x2::display::Display<AvatarNFT>>(v10, v11);
        0x2::transfer::share_object<AdminRegistry>(v13);
        let v14 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v14, v11);
        let v15 = InitEvent{admin: v11};
        0x2::event::emit<InitEvent>(v15);
    }

    public entry fun mint_avatar(arg0: vector<ElementNFT>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        elements_handling(arg0);
        let v0 = 0x1::string::utf8(b"Avatar: The Master Element");
        let v1 = AvatarNFT{
            id            : 0x2::object::new(arg2),
            name          : v0,
            description   : 0x1::string::utf8(b"The Avatar embodies the perfect balance of all elements. It grounds with Earth's stability, flows with Water's adaptability, ignites with Fire's transformation, soars with Air's intellect, and unifies with Ether's creative potential. The Avatar represents harmony, individuality, and the interconnectedness of all existence."),
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

    public entry fun mint_element(arg0: &AdminRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 3);
        let v1 = vector[b"Aether", b"Air", b"Fire", b"Earth", b"Water"];
        assert!(0x1::vector::contains<vector<u8>>(&v1, 0x1::string::as_bytes(&arg7)), 2);
        let v2 = ElementNFT{
            id            : 0x2::object::new(arg8),
            name          : arg2,
            description   : arg3,
            image_url     : arg4,
            thumbnail_url : arg5,
            project_url   : arg6,
            creator       : 0x2::address::to_string(v0),
            element_type  : arg7,
        };
        let v3 = MintElementEvent{
            object_id    : 0x2::object::id<ElementNFT>(&v2),
            recipient    : arg1,
            name         : arg2,
            element_type : arg7,
        };
        0x2::event::emit<MintElementEvent>(v3);
        if (v0 != arg1) {
            assert!(0x2::tx_context::sender(arg8) == arg1, 4);
        };
        0x2::transfer::public_transfer<ElementNFT>(v2, arg1);
    }

    fun pop_and_validate(arg0: &mut vector<ElementNFT>, arg1: &mut vector<vector<u8>>) : ElementNFT {
        let v0 = 0x1::vector::pop_back<ElementNFT>(arg0);
        let v1 = 0x1::vector::pop_back<vector<u8>>(arg1);
        assert!(0x1::string::as_bytes(&v0.element_type) == &v1, 1);
        v0
    }

    public entry fun remove_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 3);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
        let v1 = AdminRemovedEvent{admin: arg1};
        0x2::event::emit<AdminRemovedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

