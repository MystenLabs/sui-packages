module 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonPools {
    public entry fun addAuthorizedAddr(arg0: address, arg1: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg2: &mut 0x2::tx_context::TxContext) {
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::add_authorized(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::pool_index_if_owner(0x2::tx_context::sender(arg2), arg1), arg0, arg1);
    }

    public entry fun deposit<T0>(arg0: u64, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::pool_index_of(0x2::tx_context::sender(arg4), arg3), 17);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_to_pool<T0>(arg1, 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::merge_coins_and_split<T0>(arg2, arg0, arg4), arg3);
    }

    public entry fun depositAndRegister<T0>(arg0: u64, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg4: &mut 0x2::tx_context::TxContext) {
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::register_pool_index(arg1, 0x2::tx_context::sender(arg4), arg3);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_to_pool<T0>(arg1, 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::merge_coins_and_split<T0>(arg2, arg0, arg4), arg3);
    }

    public entry fun lock<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::is_encoded_valid(arg0);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::for_target_chain(arg0);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::match_coin_type<T0>(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::out_coin_index_from(arg0), arg4);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::is_eth_addr(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000 + 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::get_LOCK_TIME_PERIOD();
        assert!(v0 < 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::expire_ts_from(arg0) - 300, 46);
        let v1 = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::pool_index_of(0x2::tx_context::sender(arg6), arg4);
        assert!(v1 != 0, 16);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::check_request_signature(arg0, arg1, arg2);
        let v2 = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::get_swap_id(arg0, arg2);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_to_pending<T0>(v2, 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_from_pool<T0>(v1, 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::amount_from(arg0) - 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::fee_for_lp(arg0), arg4, arg6), arg4);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::add_locked_swap(v2, v1, v0, arg3, arg4);
    }

    public entry fun release<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::is_eth_addr(arg2);
        let v0 = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::fee_waived(arg0);
        if (v0) {
            0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::assert_is_premium_manager(0x2::tx_context::sender(arg5), arg3);
        };
        let v1 = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::get_swap_id(arg0, arg2);
        let (_, v3, v4) = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::remove_locked_swap(v1, arg4, arg3);
        assert!(v3 > 0x2::clock::timestamp_ms(arg4) / 1000, 48);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::check_release_signature(arg0, 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::eth_address_from_sui_address(v4), arg1, arg2);
        let v5 = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_from_pending<T0>(v1, arg3);
        if (!v0) {
            0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_to_pool<T0>(0, 0x2::coin::split<T0>(&mut v5, 100 * 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::service_fee(arg0), arg5), arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v4);
    }

    public entry fun removeAuthorizedAddr(arg0: address, arg1: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg2: &mut 0x2::tx_context::TxContext) {
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::remove_authorized(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::pool_index_if_owner(0x2::tx_context::sender(arg2), arg1), arg0, arg1);
    }

    public entry fun transferPoolOwner(arg0: address, arg1: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg2: &mut 0x2::tx_context::TxContext) {
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::transfer_pool_owner(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::pool_index_if_owner(0x2::tx_context::sender(arg2), arg1), arg0, arg1);
    }

    public entry fun unlock<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg3: &0x2::clock::Clock) {
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::is_eth_addr(arg1);
        let v0 = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::get_swap_id(arg0, arg1);
        let (v1, v2, _) = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::remove_locked_swap(v0, arg3, arg2);
        assert!(v2 < 0x2::clock::timestamp_ms(arg3) / 1000, 47);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_to_pool<T0>(v1, 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_from_pending<T0>(v0, arg2), arg2);
    }

    public entry fun withdraw<T0>(arg0: u64, arg1: u64, arg2: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 == 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::pool_index_if_owner(v0, arg2), 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_from_pool<T0>(arg1, arg0, arg2, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

