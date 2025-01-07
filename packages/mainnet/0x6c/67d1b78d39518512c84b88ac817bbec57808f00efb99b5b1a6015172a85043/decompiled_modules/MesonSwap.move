module 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonSwap {
    public entry fun bondSwap<T0>(arg0: vector<u8>, arg1: u64, arg2: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::pool_index_of(0x2::tx_context::sender(arg3), arg2), 17);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::bond_posted_swap(arg0, arg1, arg2);
    }

    public entry fun cancelSwap<T0>(arg0: vector<u8>, arg1: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg2: &0x2::clock::Clock) {
        assert!(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::expire_ts_from(arg0) < 0x2::clock::timestamp_ms(arg2) / 1000, 45);
        0x1::vector::push_back<u8>(&mut arg0, 255);
        let (_, _, v2) = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::remove_posted_swap(arg0, arg2, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_from_pending<T0>(arg0, arg1), v2);
    }

    public entry fun executeSwap<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: bool, arg4: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg5: &0x2::clock::Clock) {
        0x1::vector::push_back<u8>(&mut arg0, 255);
        let (v0, v1, _) = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::remove_posted_swap(arg0, arg5, arg4);
        assert!(v0 != 0, 16);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::check_release_signature(arg0, arg2, arg1, v1);
        if (arg3) {
            0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_to_pool<T0>(v0, 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_from_pending<T0>(arg0, arg4), arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_from_pending<T0>(arg0, arg4), 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::owner_of_pool(v0, arg4));
        };
    }

    public entry fun postSwap<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<0x2::coin::Coin<T0>>, arg5: &0x2::clock::Clock, arg6: &mut 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::GeneralStore, arg7: &mut 0x2::tx_context::TxContext) {
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::is_encoded_valid(arg0);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::for_initial_chain(arg0);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::match_coin_type<T0>(0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::in_coin_index_from(arg0), arg6);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::is_eth_addr(arg2);
        let v0 = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::amount_from(arg0);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::assert_amount_within_max(v0);
        let v1 = 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::expire_ts_from(arg0) - 0x2::clock::timestamp_ms(arg5) / 1000;
        assert!(v1 > 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::get_MIN_BOND_TIME_PERIOD(), 42);
        assert!(v1 < 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::get_MAX_BOND_TIME_PERIOD(), 43);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonHelpers::check_request_signature(arg0, arg1, arg2);
        0x1::vector::push_back<u8>(&mut arg0, 255);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::add_posted_swap(arg0, arg3, arg2, 0x2::tx_context::sender(arg7), arg6);
        0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::coins_to_pending<T0>(arg0, 0x6c67d1b78d39518512c84b88ac817bbec57808f00efb99b5b1a6015172a85043::MesonStates::merge_coins_and_split<T0>(arg4, v0, arg7), arg6);
    }

    // decompiled from Move bytecode v6
}

