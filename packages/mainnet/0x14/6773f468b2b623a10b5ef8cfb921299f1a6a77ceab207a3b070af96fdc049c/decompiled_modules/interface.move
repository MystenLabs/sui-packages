module 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::interface {
    public entry fun mint(arg0: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: &0x2::transfer_policy::TransferPolicy<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>, arg2: &0x2::clock::Clock, arg3: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::AV, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 == 0 || arg6 == 1, 13906834337552138239);
        assert_can_mint(arg0, arg3, arg2, arg6, arg7);
        let v0 = &arg6;
        let v1 = if (*v0 == 0) {
            3
        } else {
            assert!(*v0 == 1, 71);
            2
        };
        let v2 = 0x1::u64::min(v1, 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0));
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::add_minted_list(arg0, arg6, 0x2::tx_context::sender(arg7), v2);
        mint_and_lock(arg0, arg2, arg4, arg5, arg1, v2, arg7);
    }

    public fun add_data(arg0: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::acl::AdminWitness<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::core::CORE>, arg1: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg2: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::AV, arg3: u64, arg4: 0x1::string::String, arg5: &mut vector<0x1::string::String>, arg6: &mut vector<0x1::string::String>) {
        let v0 = 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::get_allowed_versions(arg2);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::assert_pkg_version(&v0);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::add_data(arg1, 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::create_data(arg3, arg4, arg5, arg6));
    }

    public fun add_minter_list(arg0: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::acl::AdminWitness<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::core::CORE>, arg1: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg2: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::AV, arg3: vector<address>, arg4: u64) {
        let v0 = 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::get_allowed_versions(arg2);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::assert_pkg_version(&v0);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::add_minter_list(arg1, arg4, arg3);
    }

    fun assert_can_mint(arg0: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::AV, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::get_allowed_versions(arg1);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::assert_pkg_version(&v0);
        assert!(0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::can_phase_mint(arg0, arg2, arg3), 6);
        assert!(!0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::did_mint(arg0, arg3, 0x2::tx_context::sender(arg4)), 7);
        assert!(0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::can_user_mint_phase(arg0, arg3, 0x2::tx_context::sender(arg4)), 8);
    }

    public entry fun burn(arg0: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::store::KioskStore, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>, arg4: &0x2::clock::Clock, arg5: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::AV, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: 0xc9bf66c933fd724a7bca680ebc6f4b833161d6d04968d99d286b80760e2a61c7::token::OloglyphicTablet, arg9: &mut 0x2::tx_context::TxContext) {
        assert_can_mint(arg0, arg5, arg4, 2, arg9);
        mint_and_lock(arg0, arg4, arg6, arg7, arg3, 2, arg9);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::store::add_item(arg1, arg2, arg8);
    }

    public fun burn_all(arg0: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::acl::AdminWitness<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::core::CORE>, arg1: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg2: &0x2::clock::Clock, arg3: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::AV, arg4: 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::store::KioskStore) {
        let v0 = 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::get_allowed_versions(arg3);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::assert_pkg_version(&v0);
        assert!(0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::did_burn_phase_end(arg1, arg2), 5);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::store::burn_all(arg4);
    }

    fun get_nft(arg0: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Data {
        let v0 = if (0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0) == 1) {
            0
        } else {
            0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::pseuso_random::rng(0, 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0) - 1, arg1, arg2)
        };
        if (0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0) == 1) {
            0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_pop_back(arg0)
        } else {
            0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_swap_remove(arg0, v0)
        }
    }

    public fun how_much_can_mint(arg0: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = &arg1;
        if (*v0 == 0) {
            if (0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::did_mint(arg0, arg1, 0x2::tx_context::sender(arg2))) {
                return 0
            };
            0x1::u64::min(0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0), 3)
        } else if (*v0 == 1) {
            if (0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::did_mint(arg0, arg1, 0x2::tx_context::sender(arg2))) {
                return 0
            };
            0x1::u64::min(0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0), 2)
        } else if (*v0 == 2) {
            2
        } else if (*v0 == 31) {
            0x1::u64::min(0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0), 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::how_much_can_mint_public_with_tablet(arg0, arg2))
        } else {
            assert!(*v0 == 32, 71);
            0x1::u64::min(0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0), 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::how_much_can_mint_public_without_tablet(arg0, arg2))
        }
    }

    fun mint_and_lock(arg0: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: &0x2::clock::Clock, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_nfts(arg0, arg1, arg5, arg6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(&v0)) {
            0x2::kiosk::lock<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(arg2, arg3, arg4, 0x1::vector::pop_back<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(&mut v0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(v0);
    }

    fun mint_nfts(arg0: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter> {
        let v0 = 0x1::vector::empty<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>();
        let v1 = 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::data_length(arg0);
        if (v1 == 1) {
            arg2 = 1;
        } else if (arg2 > v1) {
            arg2 = v1;
        };
        if (arg2 == 1) {
            let v2 = get_nft(arg0, arg1, arg3);
            0x1::vector::push_back<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(&mut v0, 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::mint(v2, arg3));
        } else {
            let v3 = 0;
            while (v3 < arg2) {
                let v4 = get_nft(arg0, arg1, arg3);
                0x1::vector::push_back<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(&mut v0, 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::mint(v4, arg3));
                v3 = v3 + 1;
            };
        };
        v0
    }

    public entry fun public_holder_mint(arg0: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: &0x2::transfer_policy::TransferPolicy<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>, arg2: &0x2::clock::Clock, arg3: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::AV, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0xc9bf66c933fd724a7bca680ebc6f4b833161d6d04968d99d286b80760e2a61c7::token::OloglyphicTablet, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == 500000000, 13906834462106189823);
        assert_can_mint(arg0, arg3, arg2, 31, arg8);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::add_public_tablet_minted_list(arg0, 0x2::tx_context::sender(arg8), 1);
        mint_and_lock(arg0, arg2, arg4, arg5, arg1, 1, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::receiver_address(arg0));
    }

    public entry fun public_mint(arg0: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::Mint, arg1: &0x2::transfer_policy::TransferPolicy<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>, arg2: &0x2::clock::Clock, arg3: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::allowed_versions::AV, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == 500000000, 13906834552300503039);
        assert_can_mint(arg0, arg3, arg2, 32, arg7);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::add_public_non_tablet_minted_list(arg0, 0x2::tx_context::sender(arg7), 1);
        mint_and_lock(arg0, arg2, arg4, arg5, arg1, 1, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::receiver_address(arg0));
    }

    public fun send_back_nft(arg0: &0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::acl::AdminWitness<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::core::CORE>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::store::KioskStore, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xc9bf66c933fd724a7bca680ebc6f4b833161d6d04968d99d286b80760e2a61c7::token::OloglyphicTablet>(0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::store::remove_item(arg2, arg1, arg3), arg4);
    }

    // decompiled from Move bytecode v6
}

