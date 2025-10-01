module 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace {
    public fun lock(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item) {
        0x2::kiosk::lock<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg2, arg3);
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v1;
        let v3 = v0;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_permission_ext::add(&mut v3, &v2, arg0);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_usdc_ext::install(&mut v3, &v2, arg0);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshi_ext::install(&mut v3, &v2, arg0);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshisui_ext::install(&mut v3, &v2, arg0);
        (v3, v2)
    }

    public fun delist(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::is_token_usdc(arg3)) {
            0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_usdc_ext::delist<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg2, arg4);
        } else if (0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::is_token_oshi(arg3)) {
            0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshi_ext::delist<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg2, arg4);
        } else if (0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::is_token_oshisui(arg3)) {
            0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshisui_ext::delist<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg2, arg4);
        } else {
            assert!(0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::is_token_sui(arg3), 9);
            0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_sui::delist<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg2);
        };
    }

    public fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = price_calculate(arg2, arg5);
        if (0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::is_token_usdc(arg4)) {
            0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_usdc_ext::list<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg3, v1, arg6);
        } else if (0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::is_token_oshi(arg4)) {
            0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshi_ext::list<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg3, v1, arg6);
        } else if (0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::is_token_oshisui(arg4)) {
            0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshisui_ext::list<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg3, v1, arg6);
        } else {
            assert!(0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::is_token_sui(arg4), 9);
            0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_sui::list<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg3, v1);
        };
    }

    public fun lock_rule_add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg1: &0x2::transfer_policy::TransferPolicyCap<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg3: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::add<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg2, arg3);
    }

    public fun price_calculate(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg1: u64) : (u64, u64) {
        let v0 = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::get_royalty<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1);
        (v0, arg1 - v0)
    }

    public fun purchase(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= arg3, 13906834814293508097);
        assert!(0x2::kiosk::is_listed(arg0, arg2), 13906834818588606467);
        let (v0, v1, v2) = sales_calculate(arg1, arg3);
        let (v3, v4) = split_sales_coin<0x2::sui::SUI>(arg4, v1, v2, arg7);
        let (v5, v6) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_sui::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg2, arg3, v4, arg7);
        let v7 = v6;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, 0x2::sui::SUI>(arg1, &mut v7, v0, v3);
        lock(arg5, arg6, arg1, v5);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(&mut v7, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, v7);
    }

    public fun purchase_and_create_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= arg3, 13906835364049321985);
        assert!(0x2::kiosk::is_listed(arg0, arg2), 13906835368344420355);
        let (v0, v1, v2) = sales_calculate(arg1, arg3);
        let (v3, v4) = split_sales_coin<0x2::sui::SUI>(arg4, v1, v2, arg5);
        let (v5, v6) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_sui::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg2, arg3, v4, arg5);
        let v7 = v6;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, 0x2::sui::SUI>(arg1, &mut v7, v0, v3);
        let (v8, v9) = create_kiosk(arg5);
        let v10 = v8;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_permission_ext::lock(&mut v10, v5, arg1);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(&mut v7, &v10);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, 0x2::tx_context::sender(arg5));
    }

    public fun purchase_oshi(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = sales_calculate(arg1, arg3);
        let (v3, v4) = split_sales_coin<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>(arg4, v1, v2, arg7);
        let (v5, v6) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshi_ext::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg2, v4, arg7);
        let v7 = v6;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, 0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>(arg1, &mut v7, v0, v3);
        lock(arg5, arg6, arg1, v5);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(&mut v7, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, v7);
    }

    public fun purchase_oshi_and_create_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = sales_calculate(arg1, arg3);
        let (v3, v4) = split_sales_coin<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>(arg4, v1, v2, arg5);
        let (v5, v6) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshi_ext::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg2, v4, arg5);
        let v7 = v6;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, 0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>(arg1, &mut v7, v0, v3);
        let (v8, v9) = create_kiosk(arg5);
        let v10 = v8;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_permission_ext::lock(&mut v10, v5, arg1);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(&mut v7, &v10);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, 0x2::tx_context::sender(arg5));
    }

    public fun purchase_oshisui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = sales_calculate(arg1, arg3);
        let (v3, v4) = split_sales_coin<0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>(arg4, v1, v2, arg7);
        let (v5, v6) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshisui_ext::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg2, v4, arg7);
        let v7 = v6;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, 0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>(arg1, &mut v7, v0, v3);
        lock(arg5, arg6, arg1, v5);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(&mut v7, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, v7);
    }

    public fun purchase_oshisui_and_create_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = sales_calculate(arg1, arg3);
        let (v3, v4) = split_sales_coin<0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>(arg4, v1, v2, arg5);
        let (v5, v6) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshisui_ext::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg2, v4, arg5);
        let v7 = v6;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, 0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>(arg1, &mut v7, v0, v3);
        let (v8, v9) = create_kiosk(arg5);
        let v10 = v8;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_permission_ext::lock(&mut v10, v5, arg1);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(&mut v7, &v10);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, 0x2::tx_context::sender(arg5));
    }

    public fun purchase_usdc(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = sales_calculate(arg1, arg3);
        let (v3, v4) = split_sales_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v1, v2, arg7);
        let (v5, v6) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_usdc_ext::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg2, v4, arg7);
        let v7 = v6;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, &mut v7, v0, v3);
        lock(arg5, arg6, arg1, v5);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(&mut v7, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, v7);
    }

    public fun purchase_usdc_and_create_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = sales_calculate(arg1, arg3);
        let (v3, v4) = split_sales_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v1, v2, arg5);
        let (v5, v6) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_usdc_ext::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg2, v4, arg5);
        let v7 = v6;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, &mut v7, v0, v3);
        let (v8, v9) = create_kiosk(arg5);
        let v10 = v8;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_permission_ext::lock(&mut v10, v5, arg1);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(&mut v7, &v10);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, 0x2::tx_context::sender(arg5));
    }

    public fun royalty_rule_add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg1: &0x2::transfer_policy::TransferPolicyCap<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg3: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::add<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg2, arg3);
    }

    public fun sales_calculate(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg1: u64) : (0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::RoyaltyRequest, u64, u64) {
        let v0 = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::calculate<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1);
        let v1 = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::get(&v0);
        (v0, v1, arg1 - v1)
    }

    public fun split_sales_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        (0x2::coin::split<T0>(arg0, arg1, arg3), 0x2::coin::split<T0>(arg0, arg2, arg3))
    }

    fun transfer_withdraw_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::kiosk::profits_amount(arg0) > 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::withdraw_min_amount()) {
            transfer_withdraw_coin<0x2::sui::SUI>(0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_sui::withdraw(arg0, arg1, arg2), arg2);
        };
    }

    public fun withdraw_oshi(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshi_ext::balance(arg0);
        if (v0 > 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::withdraw_min_amount()) {
            transfer_withdraw_coin<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>(0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshi_ext::withdraw(arg0, arg1, v0, arg2), arg2);
        };
    }

    public fun withdraw_oshisui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshisui_ext::balance(arg0);
        if (v0 > 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::withdraw_min_amount()) {
            transfer_withdraw_coin<0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>(0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshisui_ext::withdraw(arg0, arg1, v0, arg2), arg2);
        };
    }

    public fun withdraw_usdc(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_usdc_ext::balance(arg0);
        if (v0 > 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::withdraw_min_amount()) {
            transfer_withdraw_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_usdc_ext::withdraw(arg0, arg1, v0, arg2), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

