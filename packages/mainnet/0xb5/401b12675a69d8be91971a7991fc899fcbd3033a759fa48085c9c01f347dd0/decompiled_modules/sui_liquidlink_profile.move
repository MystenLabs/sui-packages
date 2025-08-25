module 0xb5401b12675a69d8be91971a7991fc899fcbd3033a759fa48085c9c01f347dd0::sui_liquidlink_profile {
    struct SUI_LIQUIDLINK_PROFILE has drop {
        dummy_field: bool,
    }

    struct ProfileNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        minted_at_ms: u64,
    }

    struct ProfileRegistry has key {
        id: 0x2::object::UID,
        by_owner: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct EditCap has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
    }

    public fun get_profile_id(arg0: &ProfileRegistry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.by_owner, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.by_owner, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun init(arg0: SUI_LIQUIDLINK_PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<SUI_LIQUIDLINK_PROFILE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ProfileNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<ProfileNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<ProfileNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = ProfileRegistry{
            id       : 0x2::object::new(arg1),
            by_owner : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<ProfileRegistry>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_user(arg0: &AdminCap, arg1: &mut ProfileRegistry, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileNFT{
            id           : 0x2::object::new(arg7),
            name         : 0x1::string::utf8(arg3),
            description  : 0x1::string::utf8(arg4),
            image_url    : 0x2::url::new_unsafe_from_bytes(arg5),
            minted_at_ms : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = 0x2::object::id<ProfileNFT>(&v0);
        let v2 = EditCap{
            id     : 0x2::object::new(arg7),
            nft_id : v1,
        };
        if (0x2::table::contains<address, 0x2::object::ID>(&arg1.by_owner, arg2)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.by_owner, arg2);
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.by_owner, arg2, v1);
        0x2::transfer::transfer<ProfileNFT>(v0, arg2);
        0x2::transfer::transfer<EditCap>(v2, arg2);
    }

    public fun update_image(arg0: &mut ProfileNFT, arg1: &EditCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<ProfileNFT>(arg0) == arg1.nft_id, 0);
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public fun update_texts(arg0: &mut ProfileNFT, arg1: &EditCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<ProfileNFT>(arg0) == arg1.nft_id, 0);
        arg0.name = 0x1::string::utf8(arg2);
        arg0.description = 0x1::string::utf8(arg3);
    }

    // decompiled from Move bytecode v6
}

