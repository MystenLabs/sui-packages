module 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonSwap {
    public entry fun bondSwap<T0>(arg0: vector<u8>, arg1: u64, arg2: &mut 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::GeneralStore, arg3: &mut 0x2::tx_context::TxContext) {
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::match_package_version(arg2);
        assert!(arg1 == 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::pool_index_of(0x2::tx_context::sender(arg3), arg2), 17);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::bond_posted_swap(arg0, arg1, arg2);
    }

    public entry fun cancelSwap<T0>(arg0: vector<u8>, arg1: &mut 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::GeneralStore, arg2: &0x2::clock::Clock) {
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::match_package_version(arg1);
        assert!(0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::expire_ts_from(arg0) < 0x2::clock::timestamp_ms(arg2) / 1000, 45);
        0x1::vector::push_back<u8>(&mut arg0, 255);
        let (_, _, v2) = 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::remove_posted_swap(arg0, arg2, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::coins_from_pending<T0>(arg0, arg1), v2);
    }

    public entry fun executeSwap<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: bool, arg4: &mut 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::GeneralStore, arg5: &0x2::clock::Clock) {
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::match_package_version(arg4);
        0x1::vector::push_back<u8>(&mut arg0, 255);
        let (v0, v1, _) = 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::remove_posted_swap(arg0, arg5, arg4);
        assert!(v0 != 0, 16);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::check_release_signature(arg0, arg2, arg1, v1);
        if (arg3) {
            0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::coins_to_pool<T0>(v0, 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::coins_from_pending<T0>(arg0, arg4), arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::coins_from_pending<T0>(arg0, arg4), 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::owner_of_pool(v0, arg4));
        };
    }

    public entry fun postSwapFromInitiator<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::GeneralStore, arg6: &mut 0x2::tx_context::TxContext) {
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::match_package_version(arg5);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::is_encoded_valid(arg0);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::for_initial_chain(arg0);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::match_coin_type<T0>(0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::in_coin_index_from(arg0), arg5);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::is_eth_addr(arg1);
        let v0 = 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::amount_from(arg0);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::assert_amount_within_max(v0);
        let v1 = 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::expire_ts_from(arg0) - 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v1 > 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::get_MIN_BOND_TIME_PERIOD(), 42);
        assert!(v1 < 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers::get_MAX_BOND_TIME_PERIOD(), 43);
        0x1::vector::push_back<u8>(&mut arg0, 255);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::add_posted_swap(arg0, arg2, arg1, 0x2::tx_context::sender(arg6), arg5);
        0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::coins_to_pending<T0>(arg0, 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonStates::merge_coins_and_split<T0>(arg3, v0, arg6), arg5);
    }

    // decompiled from Move bytecode v6
}

