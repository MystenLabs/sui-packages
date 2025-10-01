module 0x46f76123cc22b18757d70143b1f6e3b49fc7636aa4e80fa8b57f5a0f0dcbfa59::bravechain {
    public fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::list(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun purchase(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::purchase(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun burn(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::burn(unlock_item(arg0, arg1, arg2, arg3, arg4));
    }

    public fun mint(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg1: &0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg0, &v0), 13906834517940764673);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_permission_ext::lock(arg2, 0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::mint(arg0, arg3, arg4, arg5, arg6, arg7, arg8), arg1);
    }

    public fun balance(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) : (u64, u64, u64, u64) {
        (0x2::kiosk::profits_amount(arg0), 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_usdc_ext::balance(arg0), 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshi_ext::balance(arg0), 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_oshisui_ext::balance(arg0))
    }

    public fun create_kiosk(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg0, &v0), 13906834736984096769);
        let (v1, v2) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::create_kiosk(arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg1);
    }

    public fun delist(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::delist(arg0, arg1, arg2, arg3, arg4);
    }

    public fun delist_oshi(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::delist(arg0, arg1, arg2, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_oshi(), arg3);
    }

    public fun delist_oshisui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::delist(arg0, arg1, arg2, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_oshisui(), arg3);
    }

    public fun delist_sui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::delist(arg0, arg1, arg2, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_sui(), arg3);
    }

    public fun delist_usdc(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::delist(arg0, arg1, arg2, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_usdc(), arg3);
    }

    public fun list_oshi(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::list(arg0, arg1, arg2, arg3, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_oshi(), arg4, arg5);
    }

    public fun list_oshisui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::list(arg0, arg1, arg2, arg3, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_oshisui(), arg4, arg5);
    }

    public fun list_sui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::list(arg0, arg1, arg2, arg3, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_sui(), arg4, arg5);
    }

    public fun list_usdc(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::list(arg0, arg1, arg2, arg3, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::token_usdc(), arg4, arg5);
    }

    public fun mint_and_create_kiosk(arg0: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg1: &0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg0, &v0), 13906834599545143297);
        let (v1, v2) = 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::create_kiosk(arg8);
        let v3 = v1;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_permission_ext::lock(&mut v3, 0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::mint(arg0, arg2, arg3, arg4, arg5, arg6, arg8), arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg7);
    }

    public fun pay_charge<T0>(arg0: &0xb0f21e0466f8fb85e49eb68e75f2bdd80c7e6088f0ee24f21730d0bbc3a1cb3e::payment_registry::PaymentRegistry, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xb0f21e0466f8fb85e49eb68e75f2bdd80c7e6088f0ee24f21730d0bbc3a1cb3e::payment::pay<T0>(arg0, arg1, arg2, arg3);
    }

    public fun purchase_and_create_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::purchase_and_create_kiosk(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun purchase_oshi(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::purchase_oshi(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun purchase_oshi_and_create_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::purchase_oshi_and_create_kiosk(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun purchase_oshisui(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::purchase_oshisui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun purchase_oshisui_and_create_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::purchase_oshisui_and_create_kiosk(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun purchase_usdc(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::purchase_usdc(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun purchase_usdc_and_create_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::purchase_usdc_and_create_kiosk(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun unlock_item(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item {
        assert!(!0x2::kiosk::is_listed(arg0, arg3), 13906836115668729859);
        0x2::kiosk::list<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg1, arg3, 0);
        let (v0, v1) = 0x2::kiosk::purchase<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg0, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let v2 = v1;
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_royalty_rule::handle_burn<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, &mut v2);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule::prove_burn<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg1, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(arg2, v2);
        v0
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::withdraw(arg0, arg1, arg2);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::withdraw_usdc(arg0, arg1, arg2);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::withdraw_oshi(arg0, arg1, arg2);
        0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace::withdraw_oshisui(arg0, arg1, arg2);
    }

    public fun write_board(arg0: &mut 0x88ea4ae0d4a995635b7165ecca4a0fb5d38e8fc698ec41d5aca25667530b8336::leader_board::LeaderBoard) {
        0x88ea4ae0d4a995635b7165ecca4a0fb5d38e8fc698ec41d5aca25667530b8336::leader_board::write_board(arg0);
    }

    public fun write_history(arg0: &0x88ea4ae0d4a995635b7165ecca4a0fb5d38e8fc698ec41d5aca25667530b8336::leader_board::LeaderBoardCap, arg1: &mut 0x88ea4ae0d4a995635b7165ecca4a0fb5d38e8fc698ec41d5aca25667530b8336::leader_board::LeaderBoard) {
        0x88ea4ae0d4a995635b7165ecca4a0fb5d38e8fc698ec41d5aca25667530b8336::leader_board::write_history(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

