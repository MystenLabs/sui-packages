module 0xf4ae5f612c5a919048154e36dc589ee93d39196417033be740fc8dd0d26aaade::mochi {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Mochi has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MOCHI has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun admin_mint_nft(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 1);
        let v0 = Mochi{
            id          : 0x2::object::new(arg6),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5),
        };
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Mochi>(&v0),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Mochi>(v0, v1);
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"symbol"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://itsmochi.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Mochi"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"MOCHI"));
        let v4 = 0x2::package::claim<MOCHI>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Mochi>(&v4, v0, v2, arg1);
        0x2::display::update_version<Mochi>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Mochi>>(v5, 0x2::tx_context::sender(arg1));
        let (v7, v8) = 0x2::transfer_policy::new<Mochi>(&v4, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Mochi>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Mochi>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &0x2::transfer_policy::TransferPolicy<Mochi>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 1);
        let v0 = Mochi{
            id          : 0x2::object::new(arg9),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<Mochi>(&v0),
            creator   : 0x2::tx_context::sender(arg9),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::kiosk::place<Mochi>(arg7, arg8, v0);
    }

    public fun update_description(arg0: &AdminCap, arg1: &mut Mochi, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.description = arg2;
    }

    public fun update_nft(arg0: &AdminCap, arg1: &mut Mochi, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>) {
        arg1.name = arg2;
        arg1.description = arg3;
        arg1.image_url = arg4;
        arg1.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg5, arg6);
    }

    public fun update_nft_from_kiosk(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>) {
        let v0 = 0x2::kiosk::take<Mochi>(arg2, arg3, arg1);
        let v1 = &mut v0;
        v1.name = arg4;
        v1.description = arg5;
        v1.image_url = arg6;
        v1.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg7, arg8);
        0x2::kiosk::place<Mochi>(arg2, arg3, v0);
    }

    // decompiled from Move bytecode v6
}

