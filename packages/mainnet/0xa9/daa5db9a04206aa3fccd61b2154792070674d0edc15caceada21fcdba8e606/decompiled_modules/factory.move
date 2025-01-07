module 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::factory {
    struct UpgradeEvent<phantom T0> has copy, drop {
        is_upgradable: bool,
        random_seed_string: 0x1::string::String,
        old_nft_id: 0x2::object::ID,
    }

    public entry fun add_level_price_info<T0>(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::add_level_price_info<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun burn(arg0: 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::XYZNFT, arg1: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::burn(arg0);
    }

    public entry fun burn_cap(arg0: 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::burn_cap(arg0);
    }

    public entry fun collect_profits(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::collect_profits(arg0, arg1, arg2, arg3);
    }

    public entry fun delete_level_price_info<T0>(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: vector<u8>) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::delete_level_price_info<T0>(arg0, arg1, arg2);
    }

    public entry fun deposit_to_ref_pool(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::deposit_to_ref_pool(arg0, arg1, arg2);
    }

    public entry fun edit_level_price_info<T0>(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::edit_level_price_info<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun mint(arg0: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::mint_to_account(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun mint_with_whitelist(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::whitelist::WhitelistStorage, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::whitelist::is_whitelist(arg0, 0x2::tx_context::sender(arg3), arg3), 1);
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::free_mint_to_account(arg1, arg2, arg3);
    }

    public entry fun set_due_time(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::set_due_time(arg0, arg1, arg2, arg3);
    }

    public entry fun set_max_total_mints(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::set_max_total_mints(arg0, arg1, arg2);
    }

    public entry fun set_mint_ref_percent(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::set_mint_ref_percent(arg0, arg1, arg2);
    }

    public entry fun start_mint_pool(arg0: &0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::add_level_price_info<0x2::sui::SUI>(arg0, arg1, arg2, b"level_one", 1, b"level_two", 1000, 1000);
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::set_max_total_mints(arg0, arg1, arg3);
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::set_due_time(arg0, arg1, arg4, arg5);
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::set_mint_ref_percent(arg0, arg1, arg6);
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::deposit_to_ref_pool(arg0, arg1, arg7);
    }

    public entry fun transfer_minter_cap(arg0: 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MinterCap, arg1: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg2: &mut 0x2::tx_context::TxContext) {
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::transfer_minter_cap(arg0, arg1, arg2);
    }

    public entry fun upgrade_nft<T0, T1>(arg0: 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::XYZNFT, arg1: &0x2::clock::Clock, arg2: &mut 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::MintingTreasury, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::get_nft_next_level_name<T0>(&arg0, arg2);
        let v1 = 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::get_level_price_info<T1>(arg2, v0);
        let v2 = 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::get_level_mint_price<T1>(&v1);
        assert!(0x2::coin::value<T1>(&arg3) >= v2, 0);
        let v3 = 0x2::coin::balance_mut<T1>(&mut arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(v3, v2, arg4), 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::get_beneficiary(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(v3, 0x2::balance::value<T1>(v3) - v2, arg4), 0x2::tx_context::sender(arg4));
        let v4 = 0x2::object::new(arg4);
        let v5 = 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::random::pseudo_random_num_generator(&v4, arg1);
        let v6 = 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::random::new(v5);
        let v7 = 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::random::next_bool_with_p(&mut v6, 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::get_level_info_probability<T1>(&v1));
        0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::update_nft_to_next_level(arg0, v0, v7, arg4);
        let v8 = UpgradeEvent<0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::XYZNFT>{
            is_upgradable      : v7,
            random_seed_string : 0x1::string::utf8(v5),
            old_nft_id         : 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::get_nft_id(&arg0),
        };
        0x2::event::emit<UpgradeEvent<0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::nft::XYZNFT>>(v8);
        0x2::object::delete(v4);
        0x2::coin::destroy_zero<T1>(arg3);
    }

    // decompiled from Move bytecode v6
}

