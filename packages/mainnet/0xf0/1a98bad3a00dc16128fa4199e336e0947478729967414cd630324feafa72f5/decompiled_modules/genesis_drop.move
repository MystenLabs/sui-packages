module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_drop {
    struct GENESIS_DROP has drop {
        dummy_field: bool,
    }

    struct GenesisPass has store, key {
        id: 0x2::object::UID,
        phase: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct Sale has key {
        id: 0x2::object::UID,
        active: bool,
        start_times: vector<u64>,
        prices: vector<u64>,
        max_mints: vector<u64>,
        drops_left: u64,
    }

    public fun admin_mint_to_kiosk(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg2: &mut 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::GenesisShop, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun admin_mint_to_kiosk_and_lock(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg2: &mut 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::GenesisShop, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>, arg6: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::Weapon>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg0, arg1);
        mint_to_kiosk_impl(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun airdrop_freemint(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg0, arg1);
        let v0 = GenesisPass{
            id          : 0x2::object::new(arg3),
            phase       : 1,
            name        : 0x1::string::utf8(x"416e696d61204c616273e280992047656e657369732046726565204d696e742050617373"),
            image_url   : 0x1::string::utf8(b"QmX3vh5JiiArsDkxDuzPYGExsNm3UpjPHFH3P47sNUwzFD"),
            description : 0x1::string::utf8(x"412066726565206d696e74207469636b657420666f7220416e696d61204c616273e280992047656e657369732064726f702e"),
        };
        0x2::transfer::public_transfer<GenesisPass>(v0, arg2);
    }

    public fun airdrop_whitelist(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg0, arg1);
        let v0 = GenesisPass{
            id          : 0x2::object::new(arg3),
            phase       : 2,
            name        : 0x1::string::utf8(x"416e696d61204c616273e280992047656e657369732057686974656c6973742050617373"),
            image_url   : 0x1::string::utf8(b"QmaDx1VF1kpR4CKYzTzPRryUusnivWV6GwVFgELS65A8Fd"),
            description : 0x1::string::utf8(x"412077686974656c697374207469636b657420666f7220416e696d61204c616273e280992047656e657369732064726f702e"),
        };
        0x2::transfer::public_transfer<GenesisPass>(v0, arg2);
    }

    fun assert_can_mint(arg0: &Sale, arg1: vector<GenesisPass>, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.active && arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, 0), 3);
        assert!(arg0.drops_left >= arg3, 7);
        assert!(0x1::vector::length<GenesisPass>(&arg1) < 2, 6);
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<u64>(&arg0.start_times) > v1) {
            if (arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, v1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        let v2 = v0 - 1;
        if (0x1::vector::is_empty<GenesisPass>(&arg1)) {
            assert!(arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, 2), 1);
        } else {
            let GenesisPass {
                id          : v3,
                phase       : v4,
                name        : _,
                image_url   : _,
                description : _,
            } = 0x1::vector::pop_back<GenesisPass>(&mut arg1);
            assert!(arg4 > *0x1::vector::borrow<u64>(&arg0.start_times, v4 - 1), 2);
            0x2::object::delete(v3);
        };
        0x1::vector::destroy_empty<GenesisPass>(arg1);
        assert!(arg2 >= *0x1::vector::borrow<u64>(&arg0.prices, v2) * arg3, 4);
        assert!(arg3 <= *0x1::vector::borrow<u64>(&arg0.max_mints, v2), 5);
    }

    fun init(arg0: GENESIS_DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GENESIS_DROP>(arg0, arg1);
        let v1 = 0x2::display::new<GenesisPass>(&v0, arg1);
        0x2::display::add<GenesisPass>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<GenesisPass>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<GenesisPass>(&mut v1, 0x1::string::utf8(b"phase"), 0x1::string::utf8(b"{phase}"));
        0x2::display::add<GenesisPass>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{image_url}"));
        0x2::display::update_version<GenesisPass>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<GenesisPass>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Sale{
            id          : 0x2::object::new(arg1),
            active      : false,
            start_times : 0x1::vector::empty<u64>(),
            prices      : 0x1::vector::empty<u64>(),
            max_mints   : 0x1::vector::empty<u64>(),
            drops_left  : 3150,
        };
        0x2::transfer::share_object<Sale>(v2);
    }

    public fun mint_to_avatar(arg0: &mut Sale, arg1: &mut 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::GenesisShop, arg2: vector<GenesisPass>, arg3: &0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::profile_pictures::ProfilePictures, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::avatar::Avatar {
        assert_can_mint(arg0, arg2, 0x2::coin::value<0x2::sui::SUI>(&arg4), 1, 0x2::clock::timestamp_ms(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0xa5ecbb1b4199a962418ec18b2a7f6f60d9160f11f3c81d3c9438cf623d52a43d);
        arg0.drops_left = arg0.drops_left - 1;
        let v0 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::genesis_mint_types();
        let v1 = 0x1::vector::empty<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>();
        while (!0x1::vector::is_empty<0x1::string::String>(&v0)) {
            let v2 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::borrow_item_mut(arg1, 0x1::vector::pop_back<0x1::string::String>(&mut v0));
            let v3 = if (0x2::table_vec::length<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(v2) == 1) {
                0
            } else {
                0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::pseuso_random::rng(0, 0x2::table_vec::length<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(v2) - 1, arg5, arg6)
            };
            0x1::vector::push_back<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(&mut v1, 0x2::table_vec::swap_remove<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(v2, v3));
        };
        let v4 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::avatar::new_genesis_edition(arg6);
        let v5 = b"";
        let v6 = b"";
        let v7 = b"";
        while (!0x1::vector::is_empty<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(&v1)) {
            let (v8, v9, v10, v11, v12, v13, v14, v15, v16) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::unpack(0x1::vector::pop_back<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(&mut v1));
            if (v10 == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::helm()) {
                v7 = v8;
            } else if (v10 == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::chestpiece()) {
                v6 = v8;
            } else if (v10 == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::upper_torso()) {
                v5 = v8;
            };
            if (v10 != 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::primary() && v10 != 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::secondary() && v10 != 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::tertiary()) {
                0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::avatar::equip_minted_cosmetic(&mut v4, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::new(v8, v9, v14, v15, v16, v10, v11, 0x1::string::utf8(b"Genesis"), v12, v13, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::pseuso_random::rng(0, 1000000000, arg5, arg6), arg6));
                continue
            };
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::avatar::equip_minted_weapon(&mut v4, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::new(v8, v9, v14, v15, v16, v10, v11, 0x1::string::utf8(b"Genesis"), v12, v13, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::pseuso_random::rng(930000000, 1000000000, arg5, arg6), arg6));
        };
        0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::avatar::set_image(&mut v4, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::profile_pictures::get(arg3, v7, v6, v5));
        v4
    }

    public fun mint_to_kiosk(arg0: &mut Sale, arg1: &mut 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::GenesisShop, arg2: vector<GenesisPass>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun mint_to_kiosk_and_lock(arg0: &mut Sale, arg1: &mut 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::GenesisShop, arg2: vector<GenesisPass>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>, arg6: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::Weapon>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_can_mint(arg0, arg2, 0x2::coin::value<0x2::sui::SUI>(&arg7), arg8, 0x2::clock::timestamp_ms(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, @0xa5ecbb1b4199a962418ec18b2a7f6f60d9160f11f3c81d3c9438cf623d52a43d);
        arg0.drops_left = arg0.drops_left - arg8;
        mint_to_kiosk_impl(arg1, arg3, arg4, arg5, arg6, arg8, arg9, arg10);
    }

    fun mint_to_kiosk_impl(arg0: &mut 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::GenesisShop, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>, arg4: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::Weapon>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg1), 8);
        while (arg5 > 0) {
            let v0 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::genesis_mint_types();
            while (!0x1::vector::is_empty<0x1::string::String>(&v0)) {
                let v1 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::borrow_item_mut(arg0, 0x1::vector::pop_back<0x1::string::String>(&mut v0));
                let v2 = if (0x2::table_vec::length<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(v1) == 1) {
                    0
                } else {
                    0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::pseuso_random::rng(0, 0x2::table_vec::length<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(v1) - 1, arg6, arg7)
                };
                let (v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::unpack(0x2::table_vec::swap_remove<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::genesis_shop::Item>(v1, v2));
                if (v5 != 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::primary() && v5 != 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::secondary() && v5 != 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::tertiary()) {
                    0x2::kiosk::lock<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(arg1, arg2, arg3, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::new(v3, v4, v9, v10, v11, v5, v6, 0x1::string::utf8(b"Genesis"), v7, v8, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::pseuso_random::rng(0, 1000000000, arg6, arg7), arg7));
                    continue
                };
                0x2::kiosk::lock<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::Weapon>(arg1, arg2, arg4, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::new(v3, v4, v9, v10, v11, v5, v6, 0x1::string::utf8(b"Genesis"), v7, v8, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::pseuso_random::rng(930000000, 1000000000, arg6, arg7), arg7));
            };
            arg5 = arg5 - 1;
        };
    }

    public fun pass_description(arg0: &GenesisPass) : 0x1::string::String {
        arg0.description
    }

    public fun pass_image_url(arg0: &GenesisPass) : 0x1::string::String {
        arg0.image_url
    }

    public fun pass_name(arg0: &GenesisPass) : 0x1::string::String {
        arg0.name
    }

    public fun pass_phase(arg0: &GenesisPass) : u64 {
        arg0.phase
    }

    public fun set_active(arg0: &mut Sale, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: bool) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.active = arg3;
    }

    public fun set_drops_left(arg0: &mut Sale, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: u64) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.drops_left = arg3;
    }

    public fun set_max_mints(arg0: &mut Sale, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: vector<u64>) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.max_mints = arg3;
    }

    public fun set_prices(arg0: &mut Sale, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: vector<u64>) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.prices = arg3;
    }

    public fun set_start_times(arg0: &mut Sale, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: vector<u64>) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.start_times = arg3;
    }

    // decompiled from Move bytecode v6
}

