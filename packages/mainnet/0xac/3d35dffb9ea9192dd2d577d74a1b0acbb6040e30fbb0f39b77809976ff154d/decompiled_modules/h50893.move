module 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h50893 {
    public fun h09bcc<T0>(arg0: &0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::Ha4cb5, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &mut 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::H032e6, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: bool, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: vector<u64>, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = !0x1::vector::is_empty<u64>(&arg10) || !0x1::vector::is_empty<u64>(&arg11);
        assert!(arg7 || !v0, 540);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::h295f4<T0>(arg3, arg2, &arg1);
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T0>(&arg1);
        if (v1 == 1) {
            0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(518, 0, 915);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg1);
            return
        };
        let (v2, v3, v4, v5) = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h85f29<T0>(&arg1);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h5de86(v2, v3);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hb430b(&arg12, &arg13, &arg14);
        let v6 = 0x1::vector::length<u64>(&arg12);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::he1855(&arg15, v6);
        let v7 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h78a5d(v6);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h9ef43(&arg8, &mut v7);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h9ef43(&arg9, &mut v7);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h9ef43(&arg10, &mut v7);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h9ef43(&arg11, &mut v7);
        let v8 = 0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::h4e71a(arg0, arg17);
        if (v1 == 2) {
            let v9 = &mut arg1;
            h11b51<T0>(v9, v8, arg2, arg3);
            0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(519, 0, 916);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg1);
            return
        };
        if (!0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h7f984::h32780<T0>(&mut arg1, v8, arg2, arg3, arg4, arg5, arg6)) {
            let v10 = &mut arg1;
            h11b51<T0>(v10, v8, arg2, arg3);
            0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(525, 0, 917);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg1);
            return
        };
        if (arg7) {
            let v11 = &mut arg1;
            h11b51<T0>(v11, v8, arg2, arg3);
        };
        let v12 = 0x2::clock::timestamp_ms(arg6);
        let v13 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h7f984::hb2e0b<T0>(&arg1, arg4, arg6);
        let v14 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg1));
        let (v15, v16) = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::hfa5fc<T0>(&arg1);
        let v17 = v16;
        let v18 = v15;
        let (v19, v20) = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h7f984::h8adf6<T0>(&arg1, arg2, arg3, v13, v14);
        let v21 = v20;
        let v22 = v19;
        let v23 = if (arg7 || 0x1::vector::is_empty<u64>(&arg8)) {
            0x1::option::none<u64>()
        } else {
            h5532c<T0>(&arg1, arg3, true)
        };
        let v24 = v23;
        let v25 = if (arg7 || 0x1::vector::is_empty<u64>(&arg9)) {
            0x1::option::none<u64>()
        } else {
            h5532c<T0>(&arg1, arg3, false)
        };
        let v26 = v25;
        let v27 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hde79f(&arg8, true, &arg12, &arg13, &arg14, v12, v2, v3, v4, &v18, &v17, &v24, v13, &mut v22, 920);
        let v28 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hde79f(&arg9, false, &arg12, &arg13, &arg14, v12, v2, v3, v4, &v18, &v17, &v26, v13, &mut v21, 920);
        let (v29, v30, v31, v32, v33, v34, v35) = if (v0) {
            let v36 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg2);
            let v37 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::h5cc29(arg3);
            let (v38, v39, v40) = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::hbacbb(arg3);
            let v41 = (arg16 as u256) * v14;
            let (_, _, _, _, v46) = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::h552f1(arg3);
            let v47 = (v46 as u256) * v14;
            let (v48, v49) = hafd7c(&arg10, &arg12, true, v2, &v18, &v17);
            let v50 = v49;
            let v51 = v48;
            let (v52, v53) = hafd7c(&arg11, &arg12, false, v2, &v18, &v17);
            let v54 = v53;
            let v55 = v52;
            let v56 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hca436(&v51, &v50, &arg13, &arg14, v12, v2, v3, v4, v13, &mut v22, v47, 930);
            let v57 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hca436(&v55, &v54, &arg13, &arg14, v12, v2, v3, v4, v13, &mut v21, v47, 930);
            let v58 = h9f85c<T0>(&arg1, arg2, v5);
            let v59 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::hd5b68(arg3, true);
            let v60 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::hd5b68(arg3, false);
            let v61 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hcc276(&v56, &mut v58, v59);
            let v62 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hcc276(&v57, &mut v58, v60);
            let v63 = he95a3<T0>(&arg1, &v51, &v50, &v61, &arg15, v38, v39, v40, true, v2, &v18, &v17, v36, v37, v12, v13, v41);
            let v64 = he95a3<T0>(&arg1, &v55, &v54, &v62, &arg15, v38, v39, v40, false, v2, &v18, &v17, v36, v37, v12, v13, v41);
            0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h8f41a(&mut v56, &v63);
            0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h8f41a(&mut v57, &v64);
            (v57, v58, v59, v60, v51, v56, v55)
        } else {
            (0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hbfc36(), 0, 0, 0, vector[], 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hbfc36(), vector[])
        };
        let v65 = v30;
        let v66 = v29;
        let v67 = v35;
        let v68 = v34;
        let v69 = v33;
        let v70 = if (0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hfbcb3(&v27)) {
            true
        } else if (0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hfbcb3(&v28)) {
            true
        } else if (v0) {
            if (v65 > 0) {
                0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hfbcb3(&v68) && v31 > 0 || 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hfbcb3(&v66) && v32 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (!v70) {
            if (v0) {
                h7b932(&v69, &v68, v65, v31);
                h7b932(&v67, &v66, v65, v32);
            };
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg1);
            return
        };
        let v71 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, v8, arg2, arg4, arg5, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg6, arg17);
        let v72 = &mut v71;
        haf516<T0>(v72, &arg8, &v27, true, &arg12, &arg14);
        let v73 = &mut v71;
        haf516<T0>(v73, &arg9, &v28, false, &arg12, &arg14);
        if (v0) {
            let v74 = 0;
            let v75 = 18446744073709551615;
            let v76 = &mut v71;
            let v77 = &mut v65;
            let v78 = &mut v74;
            let v79 = &mut v75;
            hf8703<T0>(v76, arg3, &v69, &v68, true, &arg14, v77, v78, v79);
            let v80 = &mut v71;
            let v81 = &mut v65;
            let v82 = &mut v74;
            let v83 = &mut v75;
            hf8703<T0>(v80, arg3, &v67, &v66, false, &arg14, v81, v82, v83);
        };
        let (v84, v85) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(v71, v8, arg2, false, false);
        let v86 = v85;
        let v87 = v84;
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h145ed<T0>(&v87, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg2), &v86);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(v87);
    }

    fun h11b51<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &mut 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::H032e6) {
        let v0 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::h14ff8(arg3);
        hcdb71<T0>(arg0, arg1, arg2, &v0);
    }

    public fun h471e0<T0>(arg0: &0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::Ha4cb5, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: vector<u128>, arg4: &mut 0x2::tx_context::TxContext) : vector<bool> {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, 0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::h4e71a(arg0, arg4), arg2, &arg3);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h620fb(&arg3, &v0);
        v0
    }

    public fun h494c0<T0>(arg0: &0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::Ha4cb5, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_free_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, 0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::h4e71a(arg0, arg6), arg2, arg3, arg4, arg5)
    }

    fun h5532c<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::H032e6, arg2: bool) : 0x1::option::Option<u64> {
        let (v0, v1) = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::ha3a8e(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg2) {
            &v2
        } else {
            &v3
        };
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(arg0);
        let v6 = 0x1::option::none<u64>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::option::Option<u128>>(v4)) {
            if (0x1::option::is_some<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(v4, v7))) {
                let v8 = *0x1::option::borrow<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(v4, v7));
                let v9 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::get_order(v5, v8);
                if (0x1::option::is_some<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v9)) {
                    let v10 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h321c0(v8);
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

    public fun h6bcb9<T0>(arg0: &0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::Ha4cb5, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, 0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::h4e71a(arg0, arg4), arg2, arg3);
    }

    fun h7b932(arg0: &vector<u64>, arg1: &0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::H2226f, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h47e0e(arg1, v0)) {
                if (arg2 == 0) {
                    0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(521, *0x1::vector::borrow<u64>(arg0, v0), 947);
                } else if (arg3 == 0) {
                    0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(528, *0x1::vector::borrow<u64>(arg0, v0), 947);
                };
                return
            };
            v0 = v0 + 1;
        };
    }

    fun h89175<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64) : bool {
        let (v0, v1) = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::hfa5fc<T0>(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::clearing_house<T0>(arg0));
        let v2 = v1;
        let v3 = v0;
        arg1 && 0x1::option::is_some<u64>(&v2) && arg2 >= *0x1::option::borrow<u64>(&v2) || 0x1::option::is_some<u64>(&v3) && arg2 <= *0x1::option::borrow<u64>(&v3)
    }

    fun h9f85c<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: u64) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, v0)) {
            return arg2
        };
        let v1 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, v0));
        if (arg2 > v1) {
            arg2 - v1
        } else {
            0
        }
    }

    fun haf516<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: &vector<u64>, arg2: &0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::H2226f, arg3: bool, arg4: &vector<u64>, arg5: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            if (0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h47e0e(arg2, v0)) {
                let v1 = *0x1::vector::borrow<u64>(arg1, v0);
                if (!h89175<T0>(arg0, arg3, *0x1::vector::borrow<u64>(arg4, v1))) {
                    return
                };
                hd61bf<T0>(arg0, arg3, 3, *0x1::vector::borrow<u64>(arg4, v1), 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h8befd(arg2, v0), *0x1::vector::borrow<u64>(arg5, v1));
            };
            v0 = v0 + 1;
        };
    }

    fun hafd7c(arg0: &vector<u64>, arg1: &vector<u64>, arg2: bool, arg3: u64, arg4: &0x1::option::Option<u64>, arg5: &0x1::option::Option<u64>) : (vector<u64>, vector<u64>) {
        let v0 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::hbb1ea(arg0, arg1, arg2);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h646df(arg2, *0x1::vector::borrow<u64>(arg1, *0x1::vector::borrow<u64>(&v0, v2)), arg3, arg4, arg5);
            v2 = v2 + 1;
            if (0x1::option::is_none<u64>(&v3) || !0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::hcaf28(*0x1::option::borrow<u64>(&v3), arg3)) {
                0x1::vector::push_back<u64>(&mut v1, 0);
                continue
            };
            0x1::vector::push_back<u64>(&mut v1, 0x1::option::extract<u64>(&mut v3));
        };
        (v0, v1)
    }

    public fun hc6519<T0>(arg0: &0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::Ha4cb5, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &mut 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::H032e6, arg4: &mut 0x2::tx_context::TxContext) {
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::h295f4<T0>(arg3, arg2, arg1);
        h11b51<T0>(arg1, 0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::h4e71a(arg0, arg4), arg2, arg3);
    }

    fun hcdb71<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &vector<u128>) {
        if (0x1::vector::length<u128>(arg3) == 0) {
            return
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg0, arg1, arg2, arg3);
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h620fb(arg3, &v0);
    }

    fun hd61bf<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x1::option::Option<u128> {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(arg0, !arg1, arg4, arg3, arg2, 0x1::option::none<u64>(), false, hde3eb(arg5))
    }

    public fun hdadbe<T0>(arg0: &0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::Ha4cb5, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg1, 0x49201c1b119f77d579dbb53a9a7357239fb5135b02294730e5098820a9205354::ha1781::h4e71a(arg0, arg3), arg2);
    }

    fun hde3eb(arg0: u64) : 0x1::option::Option<u64> {
        if (arg0 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0)
        }
    }

    fun he95a3<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<bool>, arg4: &vector<u64>, arg5: bool, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: &0x1::option::Option<u64>, arg11: &0x1::option::Option<u64>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u256) : vector<u64> {
        let v0 = vector[];
        let v1 = 0x1::option::none<u64>();
        let v2 = 0x1::option::none<u64>();
        let v3 = false;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(arg1)) {
            let v5 = *0x1::vector::borrow<u64>(arg4, *0x1::vector::borrow<u64>(arg1, v4));
            let v6 = *0x1::vector::borrow<u64>(arg2, v4);
            let v7 = v4 + 1;
            v4 = v7;
            0x1::vector::push_back<u64>(&mut v0, v5);
            if (v6 == 0 || !*0x1::vector::borrow<bool>(arg3, v7 - 1)) {
                continue
            };
            if (arg5 && v5 > 0) {
                v3 = true;
            };
            if (0x1::option::is_none<u64>(&v1)) {
                let v8 = if (arg5) {
                    0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h0b187(arg8, v6, v5)
                } else {
                    v6
                };
                v1 = 0x1::option::some<u64>(v8);
            };
            let v9 = if (arg6) {
                0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::he6d7f(arg8, v6, arg7, arg9)
            } else {
                v6
            };
            let v10 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h6c1ab(arg8, v9, arg9);
            let v11 = if (0x1::option::is_none<u64>(&v2)) {
                true
            } else if (arg8 && v10 < *0x1::option::borrow<u64>(&v2)) {
                true
            } else {
                !arg8 && v10 > *0x1::option::borrow<u64>(&v2)
            };
            if (v11) {
                v2 = 0x1::option::some<u64>(v10);
            };
        };
        if (!v3 && !arg6 || 0x1::option::is_none<u64>(&v1)) {
            return *arg2
        };
        let v12 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h5255e<T0>(arg0, arg12, arg13, arg14, arg8, 0x1::option::extract<u64>(&mut v1), 0x1::option::extract<u64>(&mut v2), arg15, arg16);
        let v13 = if (arg8) {
            *arg11
        } else {
            *arg10
        };
        let v14 = v13;
        0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::hc125e(arg8, arg2, &v0, arg3, arg5, arg6, arg7, arg9, &v12, &v14)
    }

    fun hf8703<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: &mut 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::H032e6, arg2: &vector<u64>, arg3: &0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::H2226f, arg4: bool, arg5: &vector<u64>, arg6: &mut u64, arg7: &mut u64, arg8: &mut u64) {
        let v0 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::hd5b68(arg1, arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg2)) {
            let v2 = v1;
            v1 = v1 + 1;
            if (!0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h47e0e(arg3, v2)) {
                continue
            };
            if (*arg6 == 0) {
                0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(521, *0x1::vector::borrow<u64>(arg2, v2), 945);
                return
            };
            if (v0 == 0) {
                0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(528, *0x1::vector::borrow<u64>(arg2, v2), 946);
                return
            };
            let v3 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::he29eb(arg3, v2);
            if (arg4) {
                assert!(v3 < *arg8, 530);
            } else {
                assert!(v3 > *arg7, 530);
            };
            let v4 = hd61bf<T0>(arg0, arg4, 2, v3, 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f::h8befd(arg3, v2), *0x1::vector::borrow<u64>(arg5, *0x1::vector::borrow<u64>(arg2, v2)));
            if (0x1::option::is_some<u128>(&v4)) {
                0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h95cce::h644d5(arg1, arg4, 0x1::option::extract<u128>(&mut v4));
                *arg6 = *arg6 - 1;
                v0 = v0 - 1;
                if (arg4 && v3 > *arg7) {
                    *arg7 = v3;
                };
                if (!arg4 && v3 < *arg8) {
                    *arg8 = v3;
                };
            };
        };
    }

    // decompiled from Move bytecode v7
}

