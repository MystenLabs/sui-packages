module 0xe841484999a2ad4d960057feefbbf8a2f3d1c7ccb67f641b5ad25cec2ea3842e::fork {
    struct FORK has drop {
        dummy_field: bool,
    }

    struct Fork has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        website_url: 0x1::string::String,
        external_url: 0x1::option::Option<0x1::string::String>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NonceRegistry has key {
        id: 0x2::object::UID,
        used_nonces: 0x2::vec_map::VecMap<u64, bool>,
        admin_public_key: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AttributeUpdatedEvent has copy, drop {
        fork_id: 0x2::object::ID,
        attribute_type: 0x1::string::String,
        new_value: 0x1::string::String,
        updater: address,
    }

    struct ForkMintedEvent has copy, drop {
        fork_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        website_url: 0x1::string::String,
        external_url: 0x1::option::Option<0x1::string::String>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        owner: address,
    }

    struct ImageUrlUpdatedEvent has copy, drop {
        fork_id: 0x2::object::ID,
        new_image_url: 0x1::string::String,
        updater: address,
    }

    struct WebsiteUrlUpdatedEvent has copy, drop {
        fork_id: 0x2::object::ID,
        new_website_url: 0x1::string::String,
        updater: address,
    }

    struct ExternalUrlUpdatedEvent has copy, drop {
        fork_id: 0x2::object::ID,
        new_external_url: 0x1::option::Option<0x1::string::String>,
        updater: address,
    }

    struct DescriptionUpdatedEvent has copy, drop {
        fork_id: 0x2::object::ID,
        new_description: 0x1::string::String,
        updater: address,
    }

    struct ForkBurnedEvent has copy, drop {
        fork_id: 0x2::object::ID,
        name: 0x1::string::String,
        burned_by: address,
        burn_timestamp: u64,
    }

    public fun attributes(arg0: &Fork) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun batch_burn(arg0: &AdminCap, arg1: vector<Fork>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Fork>(&arg1)) {
            let v1 = 0x1::vector::pop_back<Fork>(&mut arg1);
            let v2 = ForkBurnedEvent{
                fork_id        : 0x2::object::id<Fork>(&v1),
                name           : v1.name,
                burned_by      : 0x2::tx_context::sender(arg2),
                burn_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
            };
            0x2::event::emit<ForkBurnedEvent>(v2);
            let Fork {
                id           : v3,
                name         : _,
                description  : _,
                image_url    : _,
                website_url  : _,
                external_url : _,
                attributes   : _,
            } = v1;
            0x2::object::delete(v3);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<Fork>(arg1);
    }

    public fun burn_by_owner(arg0: Fork, arg1: &0x2::tx_context::TxContext) {
        let v0 = ForkBurnedEvent{
            fork_id        : 0x2::object::id<Fork>(&arg0),
            name           : arg0.name,
            burned_by      : 0x2::tx_context::sender(arg1),
            burn_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<ForkBurnedEvent>(v0);
        let Fork {
            id           : v1,
            name         : _,
            description  : _,
            image_url    : _,
            website_url  : _,
            external_url : _,
            attributes   : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun cleanup_old_nonces(arg0: &AdminCap, arg1: &mut NonceRegistry, arg2: vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            let v1 = *0x1::vector::borrow<u64>(&arg2, v0);
            if (0x2::vec_map::contains<u64, bool>(&arg1.used_nonces, &v1)) {
                let (_, _) = 0x2::vec_map::remove<u64, bool>(&mut arg1.used_nonces, &v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun description(arg0: &Fork) : &0x1::string::String {
        &arg0.description
    }

    public fun external_url(arg0: &Fork) : &0x1::option::Option<0x1::string::String> {
        &arg0.external_url
    }

    public fun get_attribute_value(arg0: &Fork, arg1: 0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun image_url(arg0: &Fork) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: FORK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"website_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"external_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{website_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Maars"));
        let v5 = 0x2::package::claim<FORK>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Fork>(&v5, v1, v3, arg1);
        0x2::display::update_version<Fork>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Fork>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        let v7 = NonceRegistry{
            id               : 0x2::object::new(arg1),
            used_nonces      : 0x2::vec_map::empty<u64, bool>(),
            admin_public_key : x"d09d70560a91ad4fc24ce64b3df41c6a457f9520f9ae98d9cba2e613b28325c9",
        };
        0x2::transfer::share_object<NonceRegistry>(v7);
    }

    public fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<0x1::string::String>(&arg7), 2);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg6)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg6, v1), *0x1::vector::borrow<0x1::string::String>(&arg7, v1));
            v1 = v1 + 1;
        };
        let v2 = Fork{
            id           : 0x2::object::new(arg9),
            name         : arg1,
            description  : arg2,
            image_url    : arg3,
            website_url  : arg4,
            external_url : arg5,
            attributes   : v0,
        };
        let v3 = ForkMintedEvent{
            fork_id      : 0x2::object::id<Fork>(&v2),
            name         : arg1,
            description  : arg2,
            image_url    : arg3,
            website_url  : arg4,
            external_url : arg5,
            attributes   : v2.attributes,
            owner        : arg8,
        };
        0x2::event::emit<ForkMintedEvent>(v3);
        0x2::transfer::public_transfer<Fork>(v2, arg8);
    }

    public fun mint_with_auth(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: address, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &mut NonceRegistry, arg12: &mut 0x2::tx_context::TxContext) {
        verify_auth_and_consume_nonce(arg11, arg9, arg8, &arg10, 0x2::bcs::to_bytes<0x1::string::String>(&arg2), arg12);
        assert!(0x1::vector::length<0x1::string::String>(&arg5) == 0x1::vector::length<0x1::string::String>(&arg6), 2);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg5)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg5, v1), *0x1::vector::borrow<0x1::string::String>(&arg6, v1));
            v1 = v1 + 1;
        };
        let v2 = Fork{
            id           : 0x2::object::new(arg12),
            name         : arg0,
            description  : arg1,
            image_url    : arg2,
            website_url  : arg3,
            external_url : arg4,
            attributes   : v0,
        };
        let v3 = ForkMintedEvent{
            fork_id      : 0x2::object::id<Fork>(&v2),
            name         : arg0,
            description  : arg1,
            image_url    : arg2,
            website_url  : arg3,
            external_url : arg4,
            attributes   : v2.attributes,
            owner        : arg7,
        };
        0x2::event::emit<ForkMintedEvent>(v3);
        0x2::transfer::public_transfer<Fork>(v2, arg7);
    }

    public fun name(arg0: &Fork) : &0x1::string::String {
        &arg0.name
    }

    public fun update_admin_public_key(arg0: &AdminCap, arg1: &mut NonceRegistry, arg2: vector<u8>) {
        arg1.admin_public_key = arg2;
    }

    public fun update_description(arg0: &AdminCap, arg1: &mut Fork, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        arg1.description = arg2;
        let v0 = DescriptionUpdatedEvent{
            fork_id         : 0x2::object::id<Fork>(arg1),
            new_description : arg2,
            updater         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DescriptionUpdatedEvent>(v0);
    }

    public fun update_external_url(arg0: &AdminCap, arg1: &mut Fork, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::tx_context::TxContext) {
        arg1.external_url = arg2;
        let v0 = ExternalUrlUpdatedEvent{
            fork_id          : 0x2::object::id<Fork>(arg1),
            new_external_url : arg2,
            updater          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ExternalUrlUpdatedEvent>(v0);
    }

    public fun update_fork_metadata_with_auth(arg0: &mut Fork, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::option::Option<0x1::string::String>>, arg6: 0x1::option::Option<vector<0x1::string::String>>, arg7: 0x1::option::Option<vector<0x1::string::String>>, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &mut NonceRegistry, arg12: &0x2::tx_context::TxContext) {
        verify_auth_and_consume_nonce(arg11, arg9, arg8, &arg10, 0x2::bcs::to_bytes<0x1::option::Option<0x1::string::String>>(&arg3), arg12);
        let v0 = 0x2::object::id<Fork>(arg0);
        let v1 = 0x2::tx_context::sender(arg12);
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            arg0.name = 0x1::option::destroy_some<0x1::string::String>(arg1);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            let v2 = 0x1::option::destroy_some<0x1::string::String>(arg2);
            arg0.description = v2;
            let v3 = DescriptionUpdatedEvent{
                fork_id         : v0,
                new_description : v2,
                updater         : v1,
            };
            0x2::event::emit<DescriptionUpdatedEvent>(v3);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v4 = 0x1::option::destroy_some<0x1::string::String>(arg3);
            arg0.image_url = v4;
            let v5 = ImageUrlUpdatedEvent{
                fork_id       : v0,
                new_image_url : v4,
                updater       : v1,
            };
            0x2::event::emit<ImageUrlUpdatedEvent>(v5);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            let v6 = 0x1::option::destroy_some<0x1::string::String>(arg4);
            arg0.website_url = v6;
            let v7 = WebsiteUrlUpdatedEvent{
                fork_id         : v0,
                new_website_url : v6,
                updater         : v1,
            };
            0x2::event::emit<WebsiteUrlUpdatedEvent>(v7);
        };
        if (0x1::option::is_some<0x1::option::Option<0x1::string::String>>(&arg5)) {
            let v8 = 0x1::option::destroy_some<0x1::option::Option<0x1::string::String>>(arg5);
            arg0.external_url = v8;
            let v9 = ExternalUrlUpdatedEvent{
                fork_id          : v0,
                new_external_url : v8,
                updater          : v1,
            };
            0x2::event::emit<ExternalUrlUpdatedEvent>(v9);
        };
        if (0x1::option::is_some<vector<0x1::string::String>>(&arg6) && 0x1::option::is_some<vector<0x1::string::String>>(&arg7)) {
            let v10 = 0x1::option::destroy_some<vector<0x1::string::String>>(arg6);
            let v11 = 0x1::option::destroy_some<vector<0x1::string::String>>(arg7);
            assert!(0x1::vector::length<0x1::string::String>(&v10) == 0x1::vector::length<0x1::string::String>(&v11), 2);
            let v12 = 0;
            while (v12 < 0x1::vector::length<0x1::string::String>(&v10)) {
                let v13 = 0x1::vector::borrow<0x1::string::String>(&v10, v12);
                let v14 = 0x1::vector::borrow<0x1::string::String>(&v11, v12);
                if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, v13)) {
                    let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v13);
                    0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, *v13, *v14);
                    let v17 = AttributeUpdatedEvent{
                        fork_id        : v0,
                        attribute_type : *v13,
                        new_value      : *v14,
                        updater        : v1,
                    };
                    0x2::event::emit<AttributeUpdatedEvent>(v17);
                };
                v12 = v12 + 1;
            };
        };
    }

    public fun update_image_url(arg0: &AdminCap, arg1: &mut Fork, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = ImageUrlUpdatedEvent{
            fork_id       : 0x2::object::id<Fork>(arg1),
            new_image_url : arg2,
            updater       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ImageUrlUpdatedEvent>(v0);
    }

    public fun update_website_url(arg0: &AdminCap, arg1: &mut Fork, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        arg1.website_url = arg2;
        let v0 = WebsiteUrlUpdatedEvent{
            fork_id         : 0x2::object::id<Fork>(arg1),
            new_website_url : arg2,
            updater         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WebsiteUrlUpdatedEvent>(v0);
    }

    fun verify_auth_and_consume_nonce(arg0: &mut NonceRegistry, arg1: u64, arg2: u64, arg3: &vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch_timestamp_ms(arg5) <= arg2, 1);
        assert!(!0x2::vec_map::contains<u64, bool>(&arg0.used_nonces, &arg1), 2);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, arg4);
        let v1 = 0x2::hash::keccak256(&v0);
        assert!(0x2::ed25519::ed25519_verify(arg3, &arg0.admin_public_key, &v1), 6);
        0x2::vec_map::insert<u64, bool>(&mut arg0.used_nonces, arg1, true);
    }

    public fun website_url(arg0: &Fork) : &0x1::string::String {
        &arg0.website_url
    }

    // decompiled from Move bytecode v6
}

