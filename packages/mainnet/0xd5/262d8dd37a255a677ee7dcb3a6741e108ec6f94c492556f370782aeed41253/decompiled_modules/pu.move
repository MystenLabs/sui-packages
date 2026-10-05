module 0xd5262d8dd37a255a677ee7dcb3a6741e108ec6f94c492556f370782aeed41253::pu {
    public fun ap(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 1, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v5 = authenticated_updates(arg0, arg1, v0, arg3, arg5);
        let v6 = v5;
        if (v4) {
            v6 = update_price_feed(arg1, v5, arg4, arg5, arg6);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v6);
    }

    fun authenticated_updates(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo> {
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg0, arg3, arg4), arg4)
    }

    public fun bp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 2, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v7 = authenticated_updates(arg0, arg1, v0, arg3, arg6);
        let v8 = v7;
        if (v6) {
            v8 = update_price_feed(arg1, v7, arg4, arg6, arg7);
        };
        if (v4) {
            v8 = update_price_feed(arg1, v8, arg5, arg6, arg7);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v8);
    }

    fun cached_timestamp(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0));
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v1)
    }

    public fun cp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 3, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v9 = authenticated_updates(arg0, arg1, v0, arg3, arg7);
        let v10 = v9;
        if (v8) {
            v10 = update_price_feed(arg1, v9, arg4, arg7, arg8);
        };
        if (v6) {
            v10 = update_price_feed(arg1, v10, arg5, arg7, arg8);
        };
        if (v4) {
            v10 = update_price_feed(arg1, v10, arg6, arg7, arg8);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v10);
    }

    public fun dp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 4, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v11 = authenticated_updates(arg0, arg1, v0, arg3, arg8);
        let v12 = v11;
        if (v10) {
            v12 = update_price_feed(arg1, v11, arg4, arg8, arg9);
        };
        if (v8) {
            v12 = update_price_feed(arg1, v12, arg5, arg8, arg9);
        };
        if (v6) {
            v12 = update_price_feed(arg1, v12, arg6, arg8, arg9);
        };
        if (v4) {
            v12 = update_price_feed(arg1, v12, arg7, arg8, arg9);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v12);
    }

    public fun ep(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 5, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v13 = authenticated_updates(arg0, arg1, v0, arg3, arg9);
        let v14 = v13;
        if (v12) {
            v14 = update_price_feed(arg1, v13, arg4, arg9, arg10);
        };
        if (v10) {
            v14 = update_price_feed(arg1, v14, arg5, arg9, arg10);
        };
        if (v8) {
            v14 = update_price_feed(arg1, v14, arg6, arg9, arg10);
        };
        if (v6) {
            v14 = update_price_feed(arg1, v14, arg7, arg9, arg10);
        };
        if (v4) {
            v14 = update_price_feed(arg1, v14, arg8, arg9, arg10);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v14);
    }

    public fun fp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 6, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v15 = authenticated_updates(arg0, arg1, v0, arg3, arg10);
        let v16 = v15;
        if (v14) {
            v16 = update_price_feed(arg1, v15, arg4, arg10, arg11);
        };
        if (v12) {
            v16 = update_price_feed(arg1, v16, arg5, arg10, arg11);
        };
        if (v10) {
            v16 = update_price_feed(arg1, v16, arg6, arg10, arg11);
        };
        if (v8) {
            v16 = update_price_feed(arg1, v16, arg7, arg10, arg11);
        };
        if (v6) {
            v16 = update_price_feed(arg1, v16, arg8, arg10, arg11);
        };
        if (v4) {
            v16 = update_price_feed(arg1, v16, arg9, arg10, arg11);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v16);
    }

    public fun gp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 7, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v17 = authenticated_updates(arg0, arg1, v0, arg3, arg11);
        let v18 = v17;
        if (v16) {
            v18 = update_price_feed(arg1, v17, arg4, arg11, arg12);
        };
        if (v14) {
            v18 = update_price_feed(arg1, v18, arg5, arg11, arg12);
        };
        if (v12) {
            v18 = update_price_feed(arg1, v18, arg6, arg11, arg12);
        };
        if (v10) {
            v18 = update_price_feed(arg1, v18, arg7, arg11, arg12);
        };
        if (v8) {
            v18 = update_price_feed(arg1, v18, arg8, arg11, arg12);
        };
        if (v6) {
            v18 = update_price_feed(arg1, v18, arg9, arg11, arg12);
        };
        if (v4) {
            v18 = update_price_feed(arg1, v18, arg10, arg11, arg12);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v18);
    }

    public fun hp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 8, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v19 = authenticated_updates(arg0, arg1, v0, arg3, arg12);
        let v20 = v19;
        if (v18) {
            v20 = update_price_feed(arg1, v19, arg4, arg12, arg13);
        };
        if (v16) {
            v20 = update_price_feed(arg1, v20, arg5, arg12, arg13);
        };
        if (v14) {
            v20 = update_price_feed(arg1, v20, arg6, arg12, arg13);
        };
        if (v12) {
            v20 = update_price_feed(arg1, v20, arg7, arg12, arg13);
        };
        if (v10) {
            v20 = update_price_feed(arg1, v20, arg8, arg12, arg13);
        };
        if (v8) {
            v20 = update_price_feed(arg1, v20, arg9, arg12, arg13);
        };
        if (v6) {
            v20 = update_price_feed(arg1, v20, arg10, arg12, arg13);
        };
        if (v4) {
            v20 = update_price_feed(arg1, v20, arg11, arg12, arg13);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v20);
    }

    public fun ip(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 9, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v21 = authenticated_updates(arg0, arg1, v0, arg3, arg13);
        let v22 = v21;
        if (v20) {
            v22 = update_price_feed(arg1, v21, arg4, arg13, arg14);
        };
        if (v18) {
            v22 = update_price_feed(arg1, v22, arg5, arg13, arg14);
        };
        if (v16) {
            v22 = update_price_feed(arg1, v22, arg6, arg13, arg14);
        };
        if (v14) {
            v22 = update_price_feed(arg1, v22, arg7, arg13, arg14);
        };
        if (v12) {
            v22 = update_price_feed(arg1, v22, arg8, arg13, arg14);
        };
        if (v10) {
            v22 = update_price_feed(arg1, v22, arg9, arg13, arg14);
        };
        if (v8) {
            v22 = update_price_feed(arg1, v22, arg10, arg13, arg14);
        };
        if (v6) {
            v22 = update_price_feed(arg1, v22, arg11, arg13, arg14);
        };
        if (v4) {
            v22 = update_price_feed(arg1, v22, arg12, arg13, arg14);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v22);
    }

    public fun jp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 10, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v23 = authenticated_updates(arg0, arg1, v0, arg3, arg14);
        let v24 = v23;
        if (v22) {
            v24 = update_price_feed(arg1, v23, arg4, arg14, arg15);
        };
        if (v20) {
            v24 = update_price_feed(arg1, v24, arg5, arg14, arg15);
        };
        if (v18) {
            v24 = update_price_feed(arg1, v24, arg6, arg14, arg15);
        };
        if (v16) {
            v24 = update_price_feed(arg1, v24, arg7, arg14, arg15);
        };
        if (v14) {
            v24 = update_price_feed(arg1, v24, arg8, arg14, arg15);
        };
        if (v12) {
            v24 = update_price_feed(arg1, v24, arg9, arg14, arg15);
        };
        if (v10) {
            v24 = update_price_feed(arg1, v24, arg10, arg14, arg15);
        };
        if (v8) {
            v24 = update_price_feed(arg1, v24, arg11, arg14, arg15);
        };
        if (v6) {
            v24 = update_price_feed(arg1, v24, arg12, arg14, arg15);
        };
        if (v4) {
            v24 = update_price_feed(arg1, v24, arg13, arg14, arg15);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v24);
    }

    public fun kp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 11, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v25 = authenticated_updates(arg0, arg1, v0, arg3, arg15);
        let v26 = v25;
        if (v24) {
            v26 = update_price_feed(arg1, v25, arg4, arg15, arg16);
        };
        if (v22) {
            v26 = update_price_feed(arg1, v26, arg5, arg15, arg16);
        };
        if (v20) {
            v26 = update_price_feed(arg1, v26, arg6, arg15, arg16);
        };
        if (v18) {
            v26 = update_price_feed(arg1, v26, arg7, arg15, arg16);
        };
        if (v16) {
            v26 = update_price_feed(arg1, v26, arg8, arg15, arg16);
        };
        if (v14) {
            v26 = update_price_feed(arg1, v26, arg9, arg15, arg16);
        };
        if (v12) {
            v26 = update_price_feed(arg1, v26, arg10, arg15, arg16);
        };
        if (v10) {
            v26 = update_price_feed(arg1, v26, arg11, arg15, arg16);
        };
        if (v8) {
            v26 = update_price_feed(arg1, v26, arg12, arg15, arg16);
        };
        if (v6) {
            v26 = update_price_feed(arg1, v26, arg13, arg15, arg16);
        };
        if (v4) {
            v26 = update_price_feed(arg1, v26, arg14, arg15, arg16);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v26);
    }

    public fun lp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 12, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v27 = authenticated_updates(arg0, arg1, v0, arg3, arg16);
        let v28 = v27;
        if (v26) {
            v28 = update_price_feed(arg1, v27, arg4, arg16, arg17);
        };
        if (v24) {
            v28 = update_price_feed(arg1, v28, arg5, arg16, arg17);
        };
        if (v22) {
            v28 = update_price_feed(arg1, v28, arg6, arg16, arg17);
        };
        if (v20) {
            v28 = update_price_feed(arg1, v28, arg7, arg16, arg17);
        };
        if (v18) {
            v28 = update_price_feed(arg1, v28, arg8, arg16, arg17);
        };
        if (v16) {
            v28 = update_price_feed(arg1, v28, arg9, arg16, arg17);
        };
        if (v14) {
            v28 = update_price_feed(arg1, v28, arg10, arg16, arg17);
        };
        if (v12) {
            v28 = update_price_feed(arg1, v28, arg11, arg16, arg17);
        };
        if (v10) {
            v28 = update_price_feed(arg1, v28, arg12, arg16, arg17);
        };
        if (v8) {
            v28 = update_price_feed(arg1, v28, arg13, arg16, arg17);
        };
        if (v6) {
            v28 = update_price_feed(arg1, v28, arg14, arg16, arg17);
        };
        if (v4) {
            v28 = update_price_feed(arg1, v28, arg15, arg16, arg17);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v28);
    }

    public fun mp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 13, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v29 = authenticated_updates(arg0, arg1, v0, arg3, arg17);
        let v30 = v29;
        if (v28) {
            v30 = update_price_feed(arg1, v29, arg4, arg17, arg18);
        };
        if (v26) {
            v30 = update_price_feed(arg1, v30, arg5, arg17, arg18);
        };
        if (v24) {
            v30 = update_price_feed(arg1, v30, arg6, arg17, arg18);
        };
        if (v22) {
            v30 = update_price_feed(arg1, v30, arg7, arg17, arg18);
        };
        if (v20) {
            v30 = update_price_feed(arg1, v30, arg8, arg17, arg18);
        };
        if (v18) {
            v30 = update_price_feed(arg1, v30, arg9, arg17, arg18);
        };
        if (v16) {
            v30 = update_price_feed(arg1, v30, arg10, arg17, arg18);
        };
        if (v14) {
            v30 = update_price_feed(arg1, v30, arg11, arg17, arg18);
        };
        if (v12) {
            v30 = update_price_feed(arg1, v30, arg12, arg17, arg18);
        };
        if (v10) {
            v30 = update_price_feed(arg1, v30, arg13, arg17, arg18);
        };
        if (v8) {
            v30 = update_price_feed(arg1, v30, arg14, arg17, arg18);
        };
        if (v6) {
            v30 = update_price_feed(arg1, v30, arg15, arg17, arg18);
        };
        if (v4) {
            v30 = update_price_feed(arg1, v30, arg16, arg17, arg18);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v30);
    }

    public fun np(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 14, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v31 = authenticated_updates(arg0, arg1, v0, arg3, arg18);
        let v32 = v31;
        if (v30) {
            v32 = update_price_feed(arg1, v31, arg4, arg18, arg19);
        };
        if (v28) {
            v32 = update_price_feed(arg1, v32, arg5, arg18, arg19);
        };
        if (v26) {
            v32 = update_price_feed(arg1, v32, arg6, arg18, arg19);
        };
        if (v24) {
            v32 = update_price_feed(arg1, v32, arg7, arg18, arg19);
        };
        if (v22) {
            v32 = update_price_feed(arg1, v32, arg8, arg18, arg19);
        };
        if (v20) {
            v32 = update_price_feed(arg1, v32, arg9, arg18, arg19);
        };
        if (v18) {
            v32 = update_price_feed(arg1, v32, arg10, arg18, arg19);
        };
        if (v16) {
            v32 = update_price_feed(arg1, v32, arg11, arg18, arg19);
        };
        if (v14) {
            v32 = update_price_feed(arg1, v32, arg12, arg18, arg19);
        };
        if (v12) {
            v32 = update_price_feed(arg1, v32, arg13, arg18, arg19);
        };
        if (v10) {
            v32 = update_price_feed(arg1, v32, arg14, arg18, arg19);
        };
        if (v8) {
            v32 = update_price_feed(arg1, v32, arg15, arg18, arg19);
        };
        if (v6) {
            v32 = update_price_feed(arg1, v32, arg16, arg18, arg19);
        };
        if (v4) {
            v32 = update_price_feed(arg1, v32, arg17, arg18, arg19);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v32);
    }

    public fun op(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 15, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v33 = authenticated_updates(arg0, arg1, v0, arg3, arg19);
        let v34 = v33;
        if (v32) {
            v34 = update_price_feed(arg1, v33, arg4, arg19, arg20);
        };
        if (v30) {
            v34 = update_price_feed(arg1, v34, arg5, arg19, arg20);
        };
        if (v28) {
            v34 = update_price_feed(arg1, v34, arg6, arg19, arg20);
        };
        if (v26) {
            v34 = update_price_feed(arg1, v34, arg7, arg19, arg20);
        };
        if (v24) {
            v34 = update_price_feed(arg1, v34, arg8, arg19, arg20);
        };
        if (v22) {
            v34 = update_price_feed(arg1, v34, arg9, arg19, arg20);
        };
        if (v20) {
            v34 = update_price_feed(arg1, v34, arg10, arg19, arg20);
        };
        if (v18) {
            v34 = update_price_feed(arg1, v34, arg11, arg19, arg20);
        };
        if (v16) {
            v34 = update_price_feed(arg1, v34, arg12, arg19, arg20);
        };
        if (v14) {
            v34 = update_price_feed(arg1, v34, arg13, arg19, arg20);
        };
        if (v12) {
            v34 = update_price_feed(arg1, v34, arg14, arg19, arg20);
        };
        if (v10) {
            v34 = update_price_feed(arg1, v34, arg15, arg19, arg20);
        };
        if (v8) {
            v34 = update_price_feed(arg1, v34, arg16, arg19, arg20);
        };
        if (v6) {
            v34 = update_price_feed(arg1, v34, arg17, arg19, arg20);
        };
        if (v4) {
            v34 = update_price_feed(arg1, v34, arg18, arg19, arg20);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v34);
    }

    public fun pp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 16, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v35 = authenticated_updates(arg0, arg1, v0, arg3, arg20);
        let v36 = v35;
        if (v34) {
            v36 = update_price_feed(arg1, v35, arg4, arg20, arg21);
        };
        if (v32) {
            v36 = update_price_feed(arg1, v36, arg5, arg20, arg21);
        };
        if (v30) {
            v36 = update_price_feed(arg1, v36, arg6, arg20, arg21);
        };
        if (v28) {
            v36 = update_price_feed(arg1, v36, arg7, arg20, arg21);
        };
        if (v26) {
            v36 = update_price_feed(arg1, v36, arg8, arg20, arg21);
        };
        if (v24) {
            v36 = update_price_feed(arg1, v36, arg9, arg20, arg21);
        };
        if (v22) {
            v36 = update_price_feed(arg1, v36, arg10, arg20, arg21);
        };
        if (v20) {
            v36 = update_price_feed(arg1, v36, arg11, arg20, arg21);
        };
        if (v18) {
            v36 = update_price_feed(arg1, v36, arg12, arg20, arg21);
        };
        if (v16) {
            v36 = update_price_feed(arg1, v36, arg13, arg20, arg21);
        };
        if (v14) {
            v36 = update_price_feed(arg1, v36, arg14, arg20, arg21);
        };
        if (v12) {
            v36 = update_price_feed(arg1, v36, arg15, arg20, arg21);
        };
        if (v10) {
            v36 = update_price_feed(arg1, v36, arg16, arg20, arg21);
        };
        if (v8) {
            v36 = update_price_feed(arg1, v36, arg17, arg20, arg21);
        };
        if (v6) {
            v36 = update_price_feed(arg1, v36, arg18, arg20, arg21);
        };
        if (v4) {
            v36 = update_price_feed(arg1, v36, arg19, arg20, arg21);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v36);
    }

    public fun qp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 17, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v37 = authenticated_updates(arg0, arg1, v0, arg3, arg21);
        let v38 = v37;
        if (v36) {
            v38 = update_price_feed(arg1, v37, arg4, arg21, arg22);
        };
        if (v34) {
            v38 = update_price_feed(arg1, v38, arg5, arg21, arg22);
        };
        if (v32) {
            v38 = update_price_feed(arg1, v38, arg6, arg21, arg22);
        };
        if (v30) {
            v38 = update_price_feed(arg1, v38, arg7, arg21, arg22);
        };
        if (v28) {
            v38 = update_price_feed(arg1, v38, arg8, arg21, arg22);
        };
        if (v26) {
            v38 = update_price_feed(arg1, v38, arg9, arg21, arg22);
        };
        if (v24) {
            v38 = update_price_feed(arg1, v38, arg10, arg21, arg22);
        };
        if (v22) {
            v38 = update_price_feed(arg1, v38, arg11, arg21, arg22);
        };
        if (v20) {
            v38 = update_price_feed(arg1, v38, arg12, arg21, arg22);
        };
        if (v18) {
            v38 = update_price_feed(arg1, v38, arg13, arg21, arg22);
        };
        if (v16) {
            v38 = update_price_feed(arg1, v38, arg14, arg21, arg22);
        };
        if (v14) {
            v38 = update_price_feed(arg1, v38, arg15, arg21, arg22);
        };
        if (v12) {
            v38 = update_price_feed(arg1, v38, arg16, arg21, arg22);
        };
        if (v10) {
            v38 = update_price_feed(arg1, v38, arg17, arg21, arg22);
        };
        if (v8) {
            v38 = update_price_feed(arg1, v38, arg18, arg21, arg22);
        };
        if (v6) {
            v38 = update_price_feed(arg1, v38, arg19, arg21, arg22);
        };
        if (v4) {
            v38 = update_price_feed(arg1, v38, arg20, arg21, arg22);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v38);
    }

    fun read_u16_be(arg0: &vector<u8>, arg1: u64) : u64 {
        ((*0x1::vector::borrow<u8>(arg0, arg1) as u64) << 8) + (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64)
    }

    fun read_u64_be(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun rp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 18, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v39 = authenticated_updates(arg0, arg1, v0, arg3, arg22);
        let v40 = v39;
        if (v38) {
            v40 = update_price_feed(arg1, v39, arg4, arg22, arg23);
        };
        if (v36) {
            v40 = update_price_feed(arg1, v40, arg5, arg22, arg23);
        };
        if (v34) {
            v40 = update_price_feed(arg1, v40, arg6, arg22, arg23);
        };
        if (v32) {
            v40 = update_price_feed(arg1, v40, arg7, arg22, arg23);
        };
        if (v30) {
            v40 = update_price_feed(arg1, v40, arg8, arg22, arg23);
        };
        if (v28) {
            v40 = update_price_feed(arg1, v40, arg9, arg22, arg23);
        };
        if (v26) {
            v40 = update_price_feed(arg1, v40, arg10, arg22, arg23);
        };
        if (v24) {
            v40 = update_price_feed(arg1, v40, arg11, arg22, arg23);
        };
        if (v22) {
            v40 = update_price_feed(arg1, v40, arg12, arg22, arg23);
        };
        if (v20) {
            v40 = update_price_feed(arg1, v40, arg13, arg22, arg23);
        };
        if (v18) {
            v40 = update_price_feed(arg1, v40, arg14, arg22, arg23);
        };
        if (v16) {
            v40 = update_price_feed(arg1, v40, arg15, arg22, arg23);
        };
        if (v14) {
            v40 = update_price_feed(arg1, v40, arg16, arg22, arg23);
        };
        if (v12) {
            v40 = update_price_feed(arg1, v40, arg17, arg22, arg23);
        };
        if (v10) {
            v40 = update_price_feed(arg1, v40, arg18, arg22, arg23);
        };
        if (v8) {
            v40 = update_price_feed(arg1, v40, arg19, arg22, arg23);
        };
        if (v6) {
            v40 = update_price_feed(arg1, v40, arg20, arg22, arg23);
        };
        if (v4) {
            v40 = update_price_feed(arg1, v40, arg21, arg22, arg23);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v40);
    }

    fun select_record(arg0: vector<u8>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &mut vector<u8>) : bool {
        validate_record(&arg0, arg1);
        if (read_u64_be(&arg0, 55) <= cached_timestamp(arg1)) {
            return false
        };
        0x1::vector::append<u8>(arg2, arg0);
        true
    }

    public fun sp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 19, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg22, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        let v39 = &mut v0;
        let v40 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v39);
        if (v40) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v41 = authenticated_updates(arg0, arg1, v0, arg3, arg23);
        let v42 = v41;
        if (v40) {
            v42 = update_price_feed(arg1, v41, arg4, arg23, arg24);
        };
        if (v38) {
            v42 = update_price_feed(arg1, v42, arg5, arg23, arg24);
        };
        if (v36) {
            v42 = update_price_feed(arg1, v42, arg6, arg23, arg24);
        };
        if (v34) {
            v42 = update_price_feed(arg1, v42, arg7, arg23, arg24);
        };
        if (v32) {
            v42 = update_price_feed(arg1, v42, arg8, arg23, arg24);
        };
        if (v30) {
            v42 = update_price_feed(arg1, v42, arg9, arg23, arg24);
        };
        if (v28) {
            v42 = update_price_feed(arg1, v42, arg10, arg23, arg24);
        };
        if (v26) {
            v42 = update_price_feed(arg1, v42, arg11, arg23, arg24);
        };
        if (v24) {
            v42 = update_price_feed(arg1, v42, arg12, arg23, arg24);
        };
        if (v22) {
            v42 = update_price_feed(arg1, v42, arg13, arg23, arg24);
        };
        if (v20) {
            v42 = update_price_feed(arg1, v42, arg14, arg23, arg24);
        };
        if (v18) {
            v42 = update_price_feed(arg1, v42, arg15, arg23, arg24);
        };
        if (v16) {
            v42 = update_price_feed(arg1, v42, arg16, arg23, arg24);
        };
        if (v14) {
            v42 = update_price_feed(arg1, v42, arg17, arg23, arg24);
        };
        if (v12) {
            v42 = update_price_feed(arg1, v42, arg18, arg23, arg24);
        };
        if (v10) {
            v42 = update_price_feed(arg1, v42, arg19, arg23, arg24);
        };
        if (v8) {
            v42 = update_price_feed(arg1, v42, arg20, arg23, arg24);
        };
        if (v6) {
            v42 = update_price_feed(arg1, v42, arg21, arg23, arg24);
        };
        if (v4) {
            v42 = update_price_feed(arg1, v42, arg22, arg23, arg24);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v42);
    }

    public fun tp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg23: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 20, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg23, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg22, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        let v39 = &mut v0;
        let v40 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v39);
        if (v40) {
            v2 = v2 + 1;
        };
        let v41 = &mut v0;
        let v42 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v41);
        if (v42) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v43 = authenticated_updates(arg0, arg1, v0, arg3, arg24);
        let v44 = v43;
        if (v42) {
            v44 = update_price_feed(arg1, v43, arg4, arg24, arg25);
        };
        if (v40) {
            v44 = update_price_feed(arg1, v44, arg5, arg24, arg25);
        };
        if (v38) {
            v44 = update_price_feed(arg1, v44, arg6, arg24, arg25);
        };
        if (v36) {
            v44 = update_price_feed(arg1, v44, arg7, arg24, arg25);
        };
        if (v34) {
            v44 = update_price_feed(arg1, v44, arg8, arg24, arg25);
        };
        if (v32) {
            v44 = update_price_feed(arg1, v44, arg9, arg24, arg25);
        };
        if (v30) {
            v44 = update_price_feed(arg1, v44, arg10, arg24, arg25);
        };
        if (v28) {
            v44 = update_price_feed(arg1, v44, arg11, arg24, arg25);
        };
        if (v26) {
            v44 = update_price_feed(arg1, v44, arg12, arg24, arg25);
        };
        if (v24) {
            v44 = update_price_feed(arg1, v44, arg13, arg24, arg25);
        };
        if (v22) {
            v44 = update_price_feed(arg1, v44, arg14, arg24, arg25);
        };
        if (v20) {
            v44 = update_price_feed(arg1, v44, arg15, arg24, arg25);
        };
        if (v18) {
            v44 = update_price_feed(arg1, v44, arg16, arg24, arg25);
        };
        if (v16) {
            v44 = update_price_feed(arg1, v44, arg17, arg24, arg25);
        };
        if (v14) {
            v44 = update_price_feed(arg1, v44, arg18, arg24, arg25);
        };
        if (v12) {
            v44 = update_price_feed(arg1, v44, arg19, arg24, arg25);
        };
        if (v10) {
            v44 = update_price_feed(arg1, v44, arg20, arg24, arg25);
        };
        if (v8) {
            v44 = update_price_feed(arg1, v44, arg21, arg24, arg25);
        };
        if (v6) {
            v44 = update_price_feed(arg1, v44, arg22, arg24, arg25);
        };
        if (v4) {
            v44 = update_price_feed(arg1, v44, arg23, arg24, arg25);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v44);
    }

    public fun up(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg23: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg24: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 21, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg24, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg23, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg22, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        let v39 = &mut v0;
        let v40 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v39);
        if (v40) {
            v2 = v2 + 1;
        };
        let v41 = &mut v0;
        let v42 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v41);
        if (v42) {
            v2 = v2 + 1;
        };
        let v43 = &mut v0;
        let v44 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v43);
        if (v44) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v45 = authenticated_updates(arg0, arg1, v0, arg3, arg25);
        let v46 = v45;
        if (v44) {
            v46 = update_price_feed(arg1, v45, arg4, arg25, arg26);
        };
        if (v42) {
            v46 = update_price_feed(arg1, v46, arg5, arg25, arg26);
        };
        if (v40) {
            v46 = update_price_feed(arg1, v46, arg6, arg25, arg26);
        };
        if (v38) {
            v46 = update_price_feed(arg1, v46, arg7, arg25, arg26);
        };
        if (v36) {
            v46 = update_price_feed(arg1, v46, arg8, arg25, arg26);
        };
        if (v34) {
            v46 = update_price_feed(arg1, v46, arg9, arg25, arg26);
        };
        if (v32) {
            v46 = update_price_feed(arg1, v46, arg10, arg25, arg26);
        };
        if (v30) {
            v46 = update_price_feed(arg1, v46, arg11, arg25, arg26);
        };
        if (v28) {
            v46 = update_price_feed(arg1, v46, arg12, arg25, arg26);
        };
        if (v26) {
            v46 = update_price_feed(arg1, v46, arg13, arg25, arg26);
        };
        if (v24) {
            v46 = update_price_feed(arg1, v46, arg14, arg25, arg26);
        };
        if (v22) {
            v46 = update_price_feed(arg1, v46, arg15, arg25, arg26);
        };
        if (v20) {
            v46 = update_price_feed(arg1, v46, arg16, arg25, arg26);
        };
        if (v18) {
            v46 = update_price_feed(arg1, v46, arg17, arg25, arg26);
        };
        if (v16) {
            v46 = update_price_feed(arg1, v46, arg18, arg25, arg26);
        };
        if (v14) {
            v46 = update_price_feed(arg1, v46, arg19, arg25, arg26);
        };
        if (v12) {
            v46 = update_price_feed(arg1, v46, arg20, arg25, arg26);
        };
        if (v10) {
            v46 = update_price_feed(arg1, v46, arg21, arg25, arg26);
        };
        if (v8) {
            v46 = update_price_feed(arg1, v46, arg22, arg25, arg26);
        };
        if (v6) {
            v46 = update_price_feed(arg1, v46, arg23, arg25, arg26);
        };
        if (v4) {
            v46 = update_price_feed(arg1, v46, arg24, arg25, arg26);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v46);
    }

    fun update_price_feed(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg1: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>, arg2: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::HotPotatoVector<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo> {
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::update_single_price_feed(arg0, arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg4), arg3)
    }

    fun validate_record(arg0: &vector<u8>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 >= 55 + 8, 2);
        let v1 = read_u16_be(arg0, 0);
        assert!(v1 >= 85, 2);
        let v2 = 2 + v1;
        assert!(v2 < v0, 2);
        assert!(v0 == v2 + 1 + (*0x1::vector::borrow<u8>(arg0, v2) as u64) * 20, 2);
        assert!(*0x1::vector::borrow<u8>(arg0, 2) == 0, 2);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v3);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v4);
        let v6 = 0;
        while (v6 < 32) {
            assert!(*0x1::vector::borrow<u8>(arg0, 3 + v6) == *0x1::vector::borrow<u8>(&v5, v6), 3);
            v6 = v6 + 1;
        };
    }

    public fun vp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg23: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg24: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg25: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 22, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg25, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg24, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg23, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg22, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        let v39 = &mut v0;
        let v40 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v39);
        if (v40) {
            v2 = v2 + 1;
        };
        let v41 = &mut v0;
        let v42 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v41);
        if (v42) {
            v2 = v2 + 1;
        };
        let v43 = &mut v0;
        let v44 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v43);
        if (v44) {
            v2 = v2 + 1;
        };
        let v45 = &mut v0;
        let v46 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v45);
        if (v46) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v47 = authenticated_updates(arg0, arg1, v0, arg3, arg26);
        let v48 = v47;
        if (v46) {
            v48 = update_price_feed(arg1, v47, arg4, arg26, arg27);
        };
        if (v44) {
            v48 = update_price_feed(arg1, v48, arg5, arg26, arg27);
        };
        if (v42) {
            v48 = update_price_feed(arg1, v48, arg6, arg26, arg27);
        };
        if (v40) {
            v48 = update_price_feed(arg1, v48, arg7, arg26, arg27);
        };
        if (v38) {
            v48 = update_price_feed(arg1, v48, arg8, arg26, arg27);
        };
        if (v36) {
            v48 = update_price_feed(arg1, v48, arg9, arg26, arg27);
        };
        if (v34) {
            v48 = update_price_feed(arg1, v48, arg10, arg26, arg27);
        };
        if (v32) {
            v48 = update_price_feed(arg1, v48, arg11, arg26, arg27);
        };
        if (v30) {
            v48 = update_price_feed(arg1, v48, arg12, arg26, arg27);
        };
        if (v28) {
            v48 = update_price_feed(arg1, v48, arg13, arg26, arg27);
        };
        if (v26) {
            v48 = update_price_feed(arg1, v48, arg14, arg26, arg27);
        };
        if (v24) {
            v48 = update_price_feed(arg1, v48, arg15, arg26, arg27);
        };
        if (v22) {
            v48 = update_price_feed(arg1, v48, arg16, arg26, arg27);
        };
        if (v20) {
            v48 = update_price_feed(arg1, v48, arg17, arg26, arg27);
        };
        if (v18) {
            v48 = update_price_feed(arg1, v48, arg18, arg26, arg27);
        };
        if (v16) {
            v48 = update_price_feed(arg1, v48, arg19, arg26, arg27);
        };
        if (v14) {
            v48 = update_price_feed(arg1, v48, arg20, arg26, arg27);
        };
        if (v12) {
            v48 = update_price_feed(arg1, v48, arg21, arg26, arg27);
        };
        if (v10) {
            v48 = update_price_feed(arg1, v48, arg22, arg26, arg27);
        };
        if (v8) {
            v48 = update_price_feed(arg1, v48, arg23, arg26, arg27);
        };
        if (v6) {
            v48 = update_price_feed(arg1, v48, arg24, arg26, arg27);
        };
        if (v4) {
            v48 = update_price_feed(arg1, v48, arg25, arg26, arg27);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v48);
    }

    public fun wp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg23: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg24: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg25: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg26: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg27: &0x2::clock::Clock, arg28: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 23, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg26, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg25, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg24, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg23, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg22, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        let v39 = &mut v0;
        let v40 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v39);
        if (v40) {
            v2 = v2 + 1;
        };
        let v41 = &mut v0;
        let v42 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v41);
        if (v42) {
            v2 = v2 + 1;
        };
        let v43 = &mut v0;
        let v44 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v43);
        if (v44) {
            v2 = v2 + 1;
        };
        let v45 = &mut v0;
        let v46 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v45);
        if (v46) {
            v2 = v2 + 1;
        };
        let v47 = &mut v0;
        let v48 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v47);
        if (v48) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v49 = authenticated_updates(arg0, arg1, v0, arg3, arg27);
        let v50 = v49;
        if (v48) {
            v50 = update_price_feed(arg1, v49, arg4, arg27, arg28);
        };
        if (v46) {
            v50 = update_price_feed(arg1, v50, arg5, arg27, arg28);
        };
        if (v44) {
            v50 = update_price_feed(arg1, v50, arg6, arg27, arg28);
        };
        if (v42) {
            v50 = update_price_feed(arg1, v50, arg7, arg27, arg28);
        };
        if (v40) {
            v50 = update_price_feed(arg1, v50, arg8, arg27, arg28);
        };
        if (v38) {
            v50 = update_price_feed(arg1, v50, arg9, arg27, arg28);
        };
        if (v36) {
            v50 = update_price_feed(arg1, v50, arg10, arg27, arg28);
        };
        if (v34) {
            v50 = update_price_feed(arg1, v50, arg11, arg27, arg28);
        };
        if (v32) {
            v50 = update_price_feed(arg1, v50, arg12, arg27, arg28);
        };
        if (v30) {
            v50 = update_price_feed(arg1, v50, arg13, arg27, arg28);
        };
        if (v28) {
            v50 = update_price_feed(arg1, v50, arg14, arg27, arg28);
        };
        if (v26) {
            v50 = update_price_feed(arg1, v50, arg15, arg27, arg28);
        };
        if (v24) {
            v50 = update_price_feed(arg1, v50, arg16, arg27, arg28);
        };
        if (v22) {
            v50 = update_price_feed(arg1, v50, arg17, arg27, arg28);
        };
        if (v20) {
            v50 = update_price_feed(arg1, v50, arg18, arg27, arg28);
        };
        if (v18) {
            v50 = update_price_feed(arg1, v50, arg19, arg27, arg28);
        };
        if (v16) {
            v50 = update_price_feed(arg1, v50, arg20, arg27, arg28);
        };
        if (v14) {
            v50 = update_price_feed(arg1, v50, arg21, arg27, arg28);
        };
        if (v12) {
            v50 = update_price_feed(arg1, v50, arg22, arg27, arg28);
        };
        if (v10) {
            v50 = update_price_feed(arg1, v50, arg23, arg27, arg28);
        };
        if (v8) {
            v50 = update_price_feed(arg1, v50, arg24, arg27, arg28);
        };
        if (v6) {
            v50 = update_price_feed(arg1, v50, arg25, arg27, arg28);
        };
        if (v4) {
            v50 = update_price_feed(arg1, v50, arg26, arg27, arg28);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v50);
    }

    public fun xp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg23: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg24: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg25: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg26: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg27: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg28: &0x2::clock::Clock, arg29: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 24, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg27, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg26, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg25, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg24, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg23, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg22, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        let v39 = &mut v0;
        let v40 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v39);
        if (v40) {
            v2 = v2 + 1;
        };
        let v41 = &mut v0;
        let v42 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v41);
        if (v42) {
            v2 = v2 + 1;
        };
        let v43 = &mut v0;
        let v44 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v43);
        if (v44) {
            v2 = v2 + 1;
        };
        let v45 = &mut v0;
        let v46 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v45);
        if (v46) {
            v2 = v2 + 1;
        };
        let v47 = &mut v0;
        let v48 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v47);
        if (v48) {
            v2 = v2 + 1;
        };
        let v49 = &mut v0;
        let v50 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v49);
        if (v50) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v51 = authenticated_updates(arg0, arg1, v0, arg3, arg28);
        let v52 = v51;
        if (v50) {
            v52 = update_price_feed(arg1, v51, arg4, arg28, arg29);
        };
        if (v48) {
            v52 = update_price_feed(arg1, v52, arg5, arg28, arg29);
        };
        if (v46) {
            v52 = update_price_feed(arg1, v52, arg6, arg28, arg29);
        };
        if (v44) {
            v52 = update_price_feed(arg1, v52, arg7, arg28, arg29);
        };
        if (v42) {
            v52 = update_price_feed(arg1, v52, arg8, arg28, arg29);
        };
        if (v40) {
            v52 = update_price_feed(arg1, v52, arg9, arg28, arg29);
        };
        if (v38) {
            v52 = update_price_feed(arg1, v52, arg10, arg28, arg29);
        };
        if (v36) {
            v52 = update_price_feed(arg1, v52, arg11, arg28, arg29);
        };
        if (v34) {
            v52 = update_price_feed(arg1, v52, arg12, arg28, arg29);
        };
        if (v32) {
            v52 = update_price_feed(arg1, v52, arg13, arg28, arg29);
        };
        if (v30) {
            v52 = update_price_feed(arg1, v52, arg14, arg28, arg29);
        };
        if (v28) {
            v52 = update_price_feed(arg1, v52, arg15, arg28, arg29);
        };
        if (v26) {
            v52 = update_price_feed(arg1, v52, arg16, arg28, arg29);
        };
        if (v24) {
            v52 = update_price_feed(arg1, v52, arg17, arg28, arg29);
        };
        if (v22) {
            v52 = update_price_feed(arg1, v52, arg18, arg28, arg29);
        };
        if (v20) {
            v52 = update_price_feed(arg1, v52, arg19, arg28, arg29);
        };
        if (v18) {
            v52 = update_price_feed(arg1, v52, arg20, arg28, arg29);
        };
        if (v16) {
            v52 = update_price_feed(arg1, v52, arg21, arg28, arg29);
        };
        if (v14) {
            v52 = update_price_feed(arg1, v52, arg22, arg28, arg29);
        };
        if (v12) {
            v52 = update_price_feed(arg1, v52, arg23, arg28, arg29);
        };
        if (v10) {
            v52 = update_price_feed(arg1, v52, arg24, arg28, arg29);
        };
        if (v8) {
            v52 = update_price_feed(arg1, v52, arg25, arg28, arg29);
        };
        if (v6) {
            v52 = update_price_feed(arg1, v52, arg26, arg28, arg29);
        };
        if (v4) {
            v52 = update_price_feed(arg1, v52, arg27, arg28, arg29);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v52);
    }

    public fun yp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg23: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg24: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg25: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg26: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg27: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg28: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 25, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg28, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg27, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg26, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg25, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg24, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg23, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg22, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        let v39 = &mut v0;
        let v40 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v39);
        if (v40) {
            v2 = v2 + 1;
        };
        let v41 = &mut v0;
        let v42 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v41);
        if (v42) {
            v2 = v2 + 1;
        };
        let v43 = &mut v0;
        let v44 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v43);
        if (v44) {
            v2 = v2 + 1;
        };
        let v45 = &mut v0;
        let v46 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v45);
        if (v46) {
            v2 = v2 + 1;
        };
        let v47 = &mut v0;
        let v48 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v47);
        if (v48) {
            v2 = v2 + 1;
        };
        let v49 = &mut v0;
        let v50 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v49);
        if (v50) {
            v2 = v2 + 1;
        };
        let v51 = &mut v0;
        let v52 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v51);
        if (v52) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v53 = authenticated_updates(arg0, arg1, v0, arg3, arg29);
        let v54 = v53;
        if (v52) {
            v54 = update_price_feed(arg1, v53, arg4, arg29, arg30);
        };
        if (v50) {
            v54 = update_price_feed(arg1, v54, arg5, arg29, arg30);
        };
        if (v48) {
            v54 = update_price_feed(arg1, v54, arg6, arg29, arg30);
        };
        if (v46) {
            v54 = update_price_feed(arg1, v54, arg7, arg29, arg30);
        };
        if (v44) {
            v54 = update_price_feed(arg1, v54, arg8, arg29, arg30);
        };
        if (v42) {
            v54 = update_price_feed(arg1, v54, arg9, arg29, arg30);
        };
        if (v40) {
            v54 = update_price_feed(arg1, v54, arg10, arg29, arg30);
        };
        if (v38) {
            v54 = update_price_feed(arg1, v54, arg11, arg29, arg30);
        };
        if (v36) {
            v54 = update_price_feed(arg1, v54, arg12, arg29, arg30);
        };
        if (v34) {
            v54 = update_price_feed(arg1, v54, arg13, arg29, arg30);
        };
        if (v32) {
            v54 = update_price_feed(arg1, v54, arg14, arg29, arg30);
        };
        if (v30) {
            v54 = update_price_feed(arg1, v54, arg15, arg29, arg30);
        };
        if (v28) {
            v54 = update_price_feed(arg1, v54, arg16, arg29, arg30);
        };
        if (v26) {
            v54 = update_price_feed(arg1, v54, arg17, arg29, arg30);
        };
        if (v24) {
            v54 = update_price_feed(arg1, v54, arg18, arg29, arg30);
        };
        if (v22) {
            v54 = update_price_feed(arg1, v54, arg19, arg29, arg30);
        };
        if (v20) {
            v54 = update_price_feed(arg1, v54, arg20, arg29, arg30);
        };
        if (v18) {
            v54 = update_price_feed(arg1, v54, arg21, arg29, arg30);
        };
        if (v16) {
            v54 = update_price_feed(arg1, v54, arg22, arg29, arg30);
        };
        if (v14) {
            v54 = update_price_feed(arg1, v54, arg23, arg29, arg30);
        };
        if (v12) {
            v54 = update_price_feed(arg1, v54, arg24, arg29, arg30);
        };
        if (v10) {
            v54 = update_price_feed(arg1, v54, arg25, arg29, arg30);
        };
        if (v8) {
            v54 = update_price_feed(arg1, v54, arg26, arg29, arg30);
        };
        if (v6) {
            v54 = update_price_feed(arg1, v54, arg27, arg29, arg30);
        };
        if (v4) {
            v54 = update_price_feed(arg1, v54, arg28, arg29, arg30);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v54);
    }

    public fun zp(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg11: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg12: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg13: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg14: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg15: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg16: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg17: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg18: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg19: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg20: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg21: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg22: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg23: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg24: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg25: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg26: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg27: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg28: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg29: &mut 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg30: &0x2::clock::Clock, arg31: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 26, 1);
        let v0 = x"504e415501000000000000";
        let v1 = 0;
        let v2 = v1;
        let v3 = &mut v0;
        let v4 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg29, v3);
        if (v4) {
            v2 = v1 + 1;
        };
        let v5 = &mut v0;
        let v6 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg28, v5);
        if (v6) {
            v2 = v2 + 1;
        };
        let v7 = &mut v0;
        let v8 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg27, v7);
        if (v8) {
            v2 = v2 + 1;
        };
        let v9 = &mut v0;
        let v10 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg26, v9);
        if (v10) {
            v2 = v2 + 1;
        };
        let v11 = &mut v0;
        let v12 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg25, v11);
        if (v12) {
            v2 = v2 + 1;
        };
        let v13 = &mut v0;
        let v14 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg24, v13);
        if (v14) {
            v2 = v2 + 1;
        };
        let v15 = &mut v0;
        let v16 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg23, v15);
        if (v16) {
            v2 = v2 + 1;
        };
        let v17 = &mut v0;
        let v18 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg22, v17);
        if (v18) {
            v2 = v2 + 1;
        };
        let v19 = &mut v0;
        let v20 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg21, v19);
        if (v20) {
            v2 = v2 + 1;
        };
        let v21 = &mut v0;
        let v22 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg20, v21);
        if (v22) {
            v2 = v2 + 1;
        };
        let v23 = &mut v0;
        let v24 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg19, v23);
        if (v24) {
            v2 = v2 + 1;
        };
        let v25 = &mut v0;
        let v26 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg18, v25);
        if (v26) {
            v2 = v2 + 1;
        };
        let v27 = &mut v0;
        let v28 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg17, v27);
        if (v28) {
            v2 = v2 + 1;
        };
        let v29 = &mut v0;
        let v30 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg16, v29);
        if (v30) {
            v2 = v2 + 1;
        };
        let v31 = &mut v0;
        let v32 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg15, v31);
        if (v32) {
            v2 = v2 + 1;
        };
        let v33 = &mut v0;
        let v34 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg14, v33);
        if (v34) {
            v2 = v2 + 1;
        };
        let v35 = &mut v0;
        let v36 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg13, v35);
        if (v36) {
            v2 = v2 + 1;
        };
        let v37 = &mut v0;
        let v38 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg12, v37);
        if (v38) {
            v2 = v2 + 1;
        };
        let v39 = &mut v0;
        let v40 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg11, v39);
        if (v40) {
            v2 = v2 + 1;
        };
        let v41 = &mut v0;
        let v42 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg10, v41);
        if (v42) {
            v2 = v2 + 1;
        };
        let v43 = &mut v0;
        let v44 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg9, v43);
        if (v44) {
            v2 = v2 + 1;
        };
        let v45 = &mut v0;
        let v46 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg8, v45);
        if (v46) {
            v2 = v2 + 1;
        };
        let v47 = &mut v0;
        let v48 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg7, v47);
        if (v48) {
            v2 = v2 + 1;
        };
        let v49 = &mut v0;
        let v50 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg6, v49);
        if (v50) {
            v2 = v2 + 1;
        };
        let v51 = &mut v0;
        let v52 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg5, v51);
        if (v52) {
            v2 = v2 + 1;
        };
        let v53 = &mut v0;
        let v54 = select_record(0x1::vector::pop_back<vector<u8>>(&mut arg2), arg4, v53);
        if (v54) {
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        if (v2 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 10) = v2;
        let v55 = authenticated_updates(arg0, arg1, v0, arg3, arg30);
        let v56 = v55;
        if (v54) {
            v56 = update_price_feed(arg1, v55, arg4, arg30, arg31);
        };
        if (v52) {
            v56 = update_price_feed(arg1, v56, arg5, arg30, arg31);
        };
        if (v50) {
            v56 = update_price_feed(arg1, v56, arg6, arg30, arg31);
        };
        if (v48) {
            v56 = update_price_feed(arg1, v56, arg7, arg30, arg31);
        };
        if (v46) {
            v56 = update_price_feed(arg1, v56, arg8, arg30, arg31);
        };
        if (v44) {
            v56 = update_price_feed(arg1, v56, arg9, arg30, arg31);
        };
        if (v42) {
            v56 = update_price_feed(arg1, v56, arg10, arg30, arg31);
        };
        if (v40) {
            v56 = update_price_feed(arg1, v56, arg11, arg30, arg31);
        };
        if (v38) {
            v56 = update_price_feed(arg1, v56, arg12, arg30, arg31);
        };
        if (v36) {
            v56 = update_price_feed(arg1, v56, arg13, arg30, arg31);
        };
        if (v34) {
            v56 = update_price_feed(arg1, v56, arg14, arg30, arg31);
        };
        if (v32) {
            v56 = update_price_feed(arg1, v56, arg15, arg30, arg31);
        };
        if (v30) {
            v56 = update_price_feed(arg1, v56, arg16, arg30, arg31);
        };
        if (v28) {
            v56 = update_price_feed(arg1, v56, arg17, arg30, arg31);
        };
        if (v26) {
            v56 = update_price_feed(arg1, v56, arg18, arg30, arg31);
        };
        if (v24) {
            v56 = update_price_feed(arg1, v56, arg19, arg30, arg31);
        };
        if (v22) {
            v56 = update_price_feed(arg1, v56, arg20, arg30, arg31);
        };
        if (v20) {
            v56 = update_price_feed(arg1, v56, arg21, arg30, arg31);
        };
        if (v18) {
            v56 = update_price_feed(arg1, v56, arg22, arg30, arg31);
        };
        if (v16) {
            v56 = update_price_feed(arg1, v56, arg23, arg30, arg31);
        };
        if (v14) {
            v56 = update_price_feed(arg1, v56, arg24, arg30, arg31);
        };
        if (v12) {
            v56 = update_price_feed(arg1, v56, arg25, arg30, arg31);
        };
        if (v10) {
            v56 = update_price_feed(arg1, v56, arg26, arg30, arg31);
        };
        if (v8) {
            v56 = update_price_feed(arg1, v56, arg27, arg30, arg31);
        };
        if (v6) {
            v56 = update_price_feed(arg1, v56, arg28, arg30, arg31);
        };
        if (v4) {
            v56 = update_price_feed(arg1, v56, arg29, arg30, arg31);
        };
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::hot_potato_vector::destroy<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfo>(v56);
    }

    // decompiled from Move bytecode v7
}

