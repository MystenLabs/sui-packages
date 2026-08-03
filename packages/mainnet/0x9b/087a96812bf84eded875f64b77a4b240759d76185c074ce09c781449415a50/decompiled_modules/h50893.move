module 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h50893 {
    fun h11b51<T0>(arg0: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg2: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: &mut 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6) {
        let v0 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h14ff8(arg3);
        if (0x1::vector::length<u128>(&v0) == 0) {
            return
        };
        let v1 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::try_cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg0, arg1, arg2, &v0);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h620fb(&v0, &v1);
    }

    public fun h471e0<T0>(arg0: &0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::Ha4cb5, arg1: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg2: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: vector<u128>, arg4: &mut 0x2::tx_context::TxContext) : vector<bool> {
        let v0 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::try_cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, 0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::h4e71a(arg0, arg4), arg2, &arg3);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h620fb(&arg3, &v0);
        v0
    }

    public fun h494c0<T0>(arg0: &0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::Ha4cb5, arg1: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg2: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::deallocate_free_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, 0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::h4e71a(arg0, arg6), arg2, arg3, arg4, arg5)
    }

    fun h5532c<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: &0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6, arg2: bool) : 0x1::option::Option<u64> {
        let (v0, v1) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::ha3a8e(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg2) {
            &v2
        } else {
            &v3
        };
        let v5 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::orderbook<T0>(arg0);
        let v6 = 0x1::option::none<u64>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::option::Option<u128>>(v4)) {
            if (0x1::option::is_some<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(v4, v7))) {
                let v8 = *0x1::option::borrow<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(v4, v7));
                let v9 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::get_order(v5, v8);
                if (0x1::option::is_some<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::Order>(&v9)) {
                    let v10 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h321c0(v8);
                    if (0x1::option::is_none<u64>(&v6)) {
                        0x1::option::fill<u64>(&mut v6, v10);
                    } else if (arg2 && v10 < *0x1::option::borrow<u64>(&v6) || !arg2 && v10 > *0x1::option::borrow<u64>(&v6)) {
                        *0x1::option::borrow_mut<u64>(&mut v6) = v10;
                    };
                };
            };
            v7 = v7 + 1;
        };
        v6
    }

    public fun h6bcb9<T0>(arg0: &0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::Ha4cb5, arg1: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg2: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, 0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::h4e71a(arg0, arg4), arg2, arg3);
    }

    public fun h71386<T0>(arg0: &0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::Ha4cb5, arg1: 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg2: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: &mut 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: 0x1::option::Option<u64>, arg19: &mut 0x2::tx_context::TxContext) {
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h295f4<T0>(arg3, arg2, &arg1);
        let v0 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::market_pause_mode<T0>(&arg1);
        if (v0 == 1) {
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(518, 0, 915);
            0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(arg1);
            return
        };
        let (v1, v2, v3, v4) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h85f29<T0>(&arg1);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h5de86(v1, v2);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hb430b(&arg11, &arg12, &arg13);
        let v5 = 0x1::vector::length<u64>(&arg11);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h966c3(v5, &arg14, &arg17, arg15);
        let v6 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h78a5d(v5);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h9ef43(&arg7, &mut v6);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h9ef43(&arg8, &mut v6);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h9ef43(&arg9, &mut v6);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h9ef43(&arg10, &mut v6);
        let v7 = 0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::h4e71a(arg0, arg19);
        if (v0 == 2) {
            let v8 = &mut arg1;
            h11b51<T0>(v8, v7, arg2, arg3);
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(519, 0, 916);
            0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(arg1);
            return
        };
        if (!0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h7f984::h32780<T0>(&mut arg1, v7, arg2, arg3, arg4, arg5, arg6)) {
            let v9 = &mut arg1;
            h11b51<T0>(v9, v7, arg2, arg3);
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(525, 0, 917);
            0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(arg1);
            return
        };
        let v10 = 0x2::clock::timestamp_ms(arg6);
        let (v11, v12) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::hfa5fc<T0>(&arg1);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x1::option::is_some<u64>(&arg18) && he6c81(&arg9, &arg17);
        let v16 = 0x1::option::is_some<u64>(&arg18) && he6c81(&arg10, &arg17);
        let v17 = if (v15) {
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::hae3b3<T0>(&arg1, *0x1::option::borrow<u64>(&arg18), 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::hd00a6(arg3), v10, true)
        } else {
            vector[]
        };
        let v18 = v17;
        let v19 = if (v16) {
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::hae3b3<T0>(&arg1, *0x1::option::borrow<u64>(&arg18), 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::hd00a6(arg3), v10, false)
        } else {
            vector[]
        };
        let v20 = v19;
        let v21 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::orderbook<T0>(&arg1);
        let v22 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h350bd(v21, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h1a68c(arg3));
        let v23 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h350bd(v21, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h1bb22(arg3));
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h9a7dc(&mut v22, &arg8, &arg11, &arg12, &arg13, v10, v1, v2, true);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h9a7dc(&mut v23, &arg7, &arg11, &arg12, &arg13, v10, v1, v2, false);
        let v24 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h7f984::hb2e0b<T0>(&arg1, arg4, arg6);
        let v25 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::market::scaling_factor(0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::market_params<T0>(&arg1));
        let (v26, v27) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h7f984::h635a1<T0>(&arg1, arg2, arg3, v24, v25, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hecae9(&v22, v24), 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hecae9(&v23, v24));
        let v28 = v27;
        let v29 = v26;
        let v30 = vector[];
        let v31 = vector[];
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h60fb1(&mut v22, &arg9, &arg11, &arg12, &arg13, &arg14, &arg17, &v18, arg15, arg16, v10, true, v1, v2, &v14, &v13, v24, &mut v29, &mut v30, 918);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h60fb1(&mut v23, &arg10, &arg11, &arg12, &arg13, &arg14, &arg17, &v20, arg15, arg16, v10, false, v1, v2, &v14, &v13, v24, &mut v28, &mut v31, 918);
        let v32 = vector[];
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::he3d6c(&v22, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h1a68c(arg3), &mut v32);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::he3d6c(&v23, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h1bb22(arg3), &mut v32);
        if (0x1::vector::length<u128>(&v32) > 0) {
            let v33 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::try_cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg1, v7, arg2, &v32);
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h620fb(&v32, &v33);
        };
        let (v34, v35) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::hfa5fc<T0>(&arg1);
        let v36 = v35;
        let v37 = v34;
        let (v38, v39) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h7f984::h8adf6<T0>(&arg1, arg2, arg3, v24, v25);
        let v40 = v39;
        let v41 = v38;
        let (_, _, _, _, v46) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h552f1(arg3);
        let v47 = (v46 as u256) * v25;
        let v48 = 0x1::option::none<u64>();
        let v49 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hde79f(&arg7, false, true, &arg11, &arg12, &arg13, v10, v1, v2, v3, &v37, &v36, &v48, v24, &mut v41, 920);
        let v50 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hde79f(&arg8, false, false, &arg11, &arg12, &arg13, v10, v1, v2, v3, &v37, &v36, &v48, v24, &mut v40, 920);
        let v51 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hca436(&v30, true, &arg11, &arg12, &arg13, &arg17, &v18, v10, v1, v2, v3, &v37, &v36, v24, &mut v41, v47, 930);
        let v52 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hca436(&v31, false, &arg11, &arg12, &arg13, &arg17, &v20, v10, v1, v2, v3, &v37, &v36, v24, &mut v40, v47, 930);
        let v53 = h9f85c<T0>(&arg1, arg2, v4);
        let v54 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::hd5b68(arg3, true);
        let v55 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::hd5b68(arg3, false);
        let v56 = if (0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hfbcb3(&v49)) {
            true
        } else if (0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hfbcb3(&v50)) {
            true
        } else {
            v53 > 0 && (0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hfbcb3(&v51) && v54 > 0 || 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hfbcb3(&v52) && v55 > 0)
        };
        if (!v56) {
            h7b932(&v30, &v51, v53, v54);
            h7b932(&v31, &v52, v53, v55);
            0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(arg1);
            return
        };
        let v57 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, v7, arg2, arg4, arg5, 0x1::option::none<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::IntegratorInfo>(), arg6, arg19);
        let v58 = &mut v57;
        haf516<T0>(v58, &arg7, false, &v49, true, &arg11, &arg13);
        let v59 = &mut v57;
        haf516<T0>(v59, &arg8, false, &v50, false, &arg11, &arg13);
        let (v60, v61) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::hfa5fc<T0>(0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::clearing_house<T0>(&v57));
        let v62 = v61;
        let v63 = v60;
        let (v64, v65) = ha6ec4(arg3);
        let v66 = v65;
        let v67 = v64;
        let v68 = &mut v57;
        let v69 = &mut v53;
        let v70 = &mut v67;
        let v71 = &mut v66;
        hf8703<T0>(v68, arg3, &v30, &v51, true, &arg11, &arg13, &arg17, &v18, v1, &v63, &v62, v69, v70, v71);
        let v72 = &mut v57;
        let v73 = &mut v53;
        let v74 = &mut v67;
        let v75 = &mut v66;
        hf8703<T0>(v72, arg3, &v31, &v52, false, &arg11, &arg13, &arg17, &v20, v1, &v63, &v62, v73, v74, v75);
        let (v76, v77) = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v57, v7, arg2, false, false);
        let v78 = v77;
        let v79 = v76;
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h145ed<T0>(&v79, 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::account_id<T0>(arg2), &v78);
        0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(v79);
    }

    fun h7b932(arg0: &vector<u64>, arg1: &0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::H2226f, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h47e0e(arg1, v0)) {
                if (arg2 == 0) {
                    0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(521, *0x1::vector::borrow<u64>(arg0, v0), 947);
                } else if (arg3 == 0) {
                    0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(528, *0x1::vector::borrow<u64>(arg0, v0), 947);
                };
                return
            };
            v0 = v0 + 1;
        };
    }

    fun h89175<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64) : bool {
        let (v0, v1) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::hfa5fc<T0>(0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::clearing_house<T0>(arg0));
        let v2 = v1;
        let v3 = v0;
        arg1 && 0x1::option::is_some<u64>(&v2) && arg2 >= *0x1::option::borrow<u64>(&v2) || 0x1::option::is_some<u64>(&v3) && arg2 <= *0x1::option::borrow<u64>(&v3)
    }

    public fun h8e132<T0>(arg0: &0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::Ha4cb5, arg1: 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg2: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: &mut 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: bool, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h295f4<T0>(arg3, arg2, &arg1);
        let v0 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::market_pause_mode<T0>(&arg1);
        if (v0 == 1) {
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(518, 0, 948);
            0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(arg1);
            return
        };
        if (v0 == 2) {
            let v1 = &mut arg1;
            h11b51<T0>(v1, 0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::h4e71a(arg0, arg11), arg2, arg3);
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(519, 0, 949);
            0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(arg1);
            return
        };
        let (v2, v3, v4, _) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h85f29<T0>(&arg1);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h5de86(v2, v3);
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hb430b(&arg8, &arg9, &arg10);
        let v6 = 0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::h4e71a(arg0, arg11);
        if (!0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h7f984::h32780<T0>(&mut arg1, v6, arg2, arg3, arg4, arg5, arg6)) {
            let v7 = &mut arg1;
            h11b51<T0>(v7, v6, arg2, arg3);
            0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(525, 0, 950);
            0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(arg1);
            return
        };
        let (v8, v9) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::hfa5fc<T0>(&arg1);
        let v10 = v9;
        let v11 = v8;
        let v12 = h5532c<T0>(&arg1, arg3, arg7);
        let v13 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h7f984::hb2e0b<T0>(&arg1, arg4, arg6);
        let (v14, v15) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h7f984::h8adf6<T0>(&arg1, arg2, arg3, v13, 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::market::scaling_factor(0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::market_params<T0>(&arg1)));
        let v16 = if (arg7) {
            v14
        } else {
            v15
        };
        let v17 = v16;
        let v18 = vector[];
        let v19 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hde79f(&v18, true, arg7, &arg8, &arg9, &arg10, 0x2::clock::timestamp_ms(arg6), v2, v3, v4, &v11, &v10, &v12, v13, &mut v17, 951);
        if (!0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::hfbcb3(&v19)) {
            0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(arg1);
            return
        };
        let v20 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, v6, arg2, arg4, arg5, 0x1::option::none<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::IntegratorInfo>(), arg6, arg11);
        let v21 = &mut v20;
        haf516<T0>(v21, &v18, true, &v19, arg7, &arg8, &arg10);
        let (v22, v23) = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v20, v6, arg2, false, false);
        let v24 = v23;
        let v25 = v22;
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h145ed<T0>(&v25, 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::account_id<T0>(arg2), &v24);
        0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::share<T0>(v25);
    }

    fun h9f85c<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg2: u64) : u64 {
        let v0 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::account_id<T0>(arg1);
        if (!0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::exists_position<T0>(arg0, v0)) {
            return arg2
        };
        let v1 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::position<T0>(arg0, v0));
        if (arg2 > v1) {
            arg2 - v1
        } else {
            0
        }
    }

    fun ha6ec4(arg0: &0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6) : (u64, u64) {
        let (v0, v1) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::ha3a8e(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::option::Option<u128>>(&v3)) {
            if (0x1::option::is_some<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(&v3, v6))) {
                let v7 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h321c0(*0x1::option::borrow<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(&v3, v6)));
                if (v7 > v4) {
                    v5 = v7;
                };
            };
            v6 = v6 + 1;
        };
        let v8 = 18446744073709551615;
        let v9 = v8;
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::option::Option<u128>>(&v2)) {
            if (0x1::option::is_some<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(&v2, v10))) {
                let v11 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h321c0(*0x1::option::borrow<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(&v2, v10)));
                if (v11 < v8) {
                    v9 = v11;
                };
            };
            v10 = v10 + 1;
        };
        (v5, v9)
    }

    fun haf516<T0>(arg0: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::SessionHotPotato<T0>, arg1: &vector<u64>, arg2: bool, arg3: &0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::H2226f, arg4: bool, arg5: &vector<u64>, arg6: &vector<u64>) {
        let v0 = if (arg2) {
            0x1::vector::length<u64>(arg5)
        } else {
            0x1::vector::length<u64>(arg1)
        };
        let v1 = 0;
        while (v1 < v0) {
            if (0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h47e0e(arg3, v1)) {
                let v2 = if (arg2) {
                    v1
                } else {
                    *0x1::vector::borrow<u64>(arg1, v1)
                };
                if (!h89175<T0>(arg0, arg4, *0x1::vector::borrow<u64>(arg5, v2))) {
                    return
                };
                hd61bf<T0>(arg0, arg4, 3, *0x1::vector::borrow<u64>(arg5, v2), 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h8befd(arg3, v1), *0x1::vector::borrow<u64>(arg6, v2));
            };
            v1 = v1 + 1;
        };
    }

    public fun hc6519<T0>(arg0: &0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::Ha4cb5, arg1: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg2: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: &mut 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6, arg4: &mut 0x2::tx_context::TxContext) {
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h295f4<T0>(arg3, arg2, arg1);
        h11b51<T0>(arg1, 0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::h4e71a(arg0, arg4), arg2, arg3);
    }

    fun hd61bf<T0>(arg0: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x1::option::Option<u128> {
        0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::place_limit_order<T0>(arg0, !arg1, arg4, arg3, arg2, 0x1::option::none<u64>(), false, hde3eb(arg5))
    }

    public fun hdadbe<T0>(arg0: &0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::Ha4cb5, arg1: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg2: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, 0x48da68af773620a1e952fb5df770df425290da4fffe19573f8e34b96a9615aa8::ha1781::h4e71a(arg0, arg3), arg2);
    }

    fun hde3eb(arg0: u64) : 0x1::option::Option<u64> {
        if (arg0 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0)
        }
    }

    fun he6c81(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        if (0x1::vector::length<u64>(arg1) == 0) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg1, *0x1::vector::borrow<u64>(arg0, v0)) > 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun hf8703<T0>(arg0: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::SessionHotPotato<T0>, arg1: &mut 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6, arg2: &vector<u64>, arg3: &0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::H2226f, arg4: bool, arg5: &vector<u64>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: &vector<u64>, arg9: u64, arg10: &0x1::option::Option<u64>, arg11: &0x1::option::Option<u64>, arg12: &mut u64, arg13: &mut u64, arg14: &mut u64) {
        let v0 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::hd5b68(arg1, arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg2)) {
            let v2 = v1;
            v1 = v1 + 1;
            if (!0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h47e0e(arg3, v2)) {
                continue
            };
            let v3 = *0x1::vector::borrow<u64>(arg2, v2);
            if (*arg12 == 0) {
                0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(521, v3, 945);
                return
            };
            if (v0 == 0) {
                0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(528, v3, 946);
                return
            };
            let v4 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::hb3f96(arg4, *0x1::vector::borrow<u64>(arg5, v3), 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h6fefe(arg3, v2), arg9, arg10, arg11, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::he2d3a(arg7, v3), arg8);
            if (arg4) {
                assert!(v4 < *arg14, 530);
            } else {
                assert!(v4 > *arg13, 530);
            };
            let v5 = hd61bf<T0>(arg0, arg4, 2, v4, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f::h8befd(arg3, v2), *0x1::vector::borrow<u64>(arg6, v3));
            if (0x1::option::is_some<u128>(&v5)) {
                0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h644d5(arg1, arg4, 0x1::option::extract<u128>(&mut v5));
                *arg12 = *arg12 - 1;
                v0 = v0 - 1;
                if (arg4 && v4 > *arg13) {
                    *arg13 = v4;
                };
                if (!arg4 && v4 < *arg14) {
                    *arg14 = v4;
                };
            };
        };
    }

    // decompiled from Move bytecode v7
}

