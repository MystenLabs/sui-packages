module 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h50893 {
    public fun h09bcc<T0>(arg0: &0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::Ha4cb5, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg3: &mut 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::H032e6, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: &mut 0x2::tx_context::TxContext) {
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h295f4<T0>(arg3, arg2, &arg1);
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_pause_mode<T0>(&arg1);
        if (v0 == 1) {
            0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(518, 0, 910);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg1);
            return
        };
        let (v1, v2, v3, v4) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::h85f29<T0>(&arg1);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h5de86(v1, v2);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hb430b(&arg11, &arg12, &arg13);
        let v5 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h78a5d(0x1::vector::length<u64>(&arg11));
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9ef43(&arg7, &mut v5);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9ef43(&arg8, &mut v5);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9ef43(&arg9, &mut v5);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9ef43(&arg10, &mut v5);
        let v6 = 0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::h4e71a(arg0, arg14);
        let v7 = &mut arg1;
        h11b51<T0>(v7, v6, arg2, arg3);
        if (v0 == 2) {
            0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(519, 0, 911);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg1);
            return
        };
        if (!0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h7f984::h32780<T0>(&mut arg1, v6, arg2, arg3, arg4, arg5, arg6)) {
            0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(525, 0, 912);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg1);
            return
        };
        let (v8, v9) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::hfa5fc<T0>(&arg1);
        let v10 = v9;
        let v11 = v8;
        let v12 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h7f984::hb2e0b<T0>(&arg1, arg4, arg6);
        let v13 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::scaling_factor(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T0>(&arg1));
        let (v14, v15) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h7f984::h8adf6<T0>(&arg1, arg2, arg3, v12, v13);
        let v16 = v15;
        let v17 = v14;
        let (_, _, _, _, v22) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h552f1(arg3);
        let v23 = (v22 as u256) * v13;
        let v24 = 0x2::clock::timestamp_ms(arg6);
        let v25 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hde79f(&arg7, true, &arg11, &arg12, &arg13, v24, v1, v2, v3, &v11, &v10, v12, &mut v17, 920);
        let v26 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hde79f(&arg8, false, &arg11, &arg12, &arg13, v24, v1, v2, v3, &v11, &v10, v12, &mut v16, 920);
        let v27 = vector[];
        let v28 = vector[];
        let v29 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hca436(&arg9, true, &arg11, &arg12, &arg13, &v27, &v28, v24, v1, v2, v3, &v11, &v10, v12, &mut v17, v23, 930);
        let v30 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hca436(&arg10, false, &arg11, &arg12, &arg13, &v27, &v28, v24, v1, v2, v3, &v11, &v10, v12, &mut v16, v23, 930);
        let v31 = h9f85c<T0>(&arg1, arg2, v4);
        let v32 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::hd5b68(arg3, true);
        let v33 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::hd5b68(arg3, false);
        let v34 = if (0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hfbcb3(&v25)) {
            true
        } else if (0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hfbcb3(&v26)) {
            true
        } else {
            v31 > 0 && (0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hfbcb3(&v29) && v32 > 0 || 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hfbcb3(&v30) && v33 > 0)
        };
        if (!v34) {
            h7b932(&arg9, &v29, v31, v32);
            h7b932(&arg10, &v30, v31, v33);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg1);
            return
        };
        let v35 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::start_session<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg1, v6, arg2, arg4, arg5, 0x1::option::none<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>(), arg6, arg14);
        let v36 = &mut v35;
        haf516<T0>(v36, &arg7, &v25, true, &arg11, &arg13);
        let v37 = &mut v35;
        haf516<T0>(v37, &arg8, &v26, false, &arg11, &arg13);
        let (v38, v39) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::hfa5fc<T0>(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::clearing_house<T0>(&v35));
        let v40 = v39;
        let v41 = v38;
        let (v42, v43) = ha6ec4(arg3);
        let v44 = v43;
        let v45 = v42;
        let v46 = &mut v35;
        let v47 = &mut v31;
        let v48 = &mut v45;
        let v49 = &mut v44;
        hf8703<T0>(v46, arg3, &arg9, &v29, true, &arg11, &arg13, &v27, &v28, v1, &v41, &v40, v47, v48, v49);
        let v50 = &mut v35;
        let v51 = &mut v31;
        let v52 = &mut v45;
        let v53 = &mut v44;
        hf8703<T0>(v50, arg3, &arg10, &v30, false, &arg11, &arg13, &v27, &v28, v1, &v41, &v40, v51, v52, v53);
        let (v54, v55) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::end_session<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(v35, v6, arg2, false, false);
        let v56 = v55;
        let v57 = v54;
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h145ed<T0>(&v57, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg2), &v56);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(v57);
    }

    fun h11b51<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ACCOUNT, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg3: &mut 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::H032e6) {
        let v0 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h14ff8(arg3);
        if (0x1::vector::length<u128>(&v0) == 0) {
            return
        };
        let v1 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::try_cancel_orders<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg0, arg1, arg2, &v0);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h620fb(&v0, &v1);
    }

    public fun h471e0<T0>(arg0: &0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::Ha4cb5, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg3: vector<u128>, arg4: &mut 0x2::tx_context::TxContext) : vector<bool> {
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::try_cancel_orders<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg1, 0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::h4e71a(arg0, arg4), arg2, &arg3);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h620fb(&arg3, &v0);
        v0
    }

    public fun h494c0<T0>(arg0: &0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::Ha4cb5, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg3: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::deallocate_free_collateral<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg1, 0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::h4e71a(arg0, arg6), arg2, arg3, arg4, arg5)
    }

    public fun h6bcb9<T0>(arg0: &0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::Ha4cb5, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::allocate_collateral<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg1, 0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::h4e71a(arg0, arg4), arg2, arg3);
    }

    public fun h71386<T0>(arg0: &0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::Ha4cb5, arg1: 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg2: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg3: &mut 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::H032e6, arg4: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg5: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: u64, arg16: u64, arg17: vector<u64>, arg18: 0x1::option::Option<u64>, arg19: &mut 0x2::tx_context::TxContext) {
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h295f4<T0>(arg3, arg2, &arg1);
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_pause_mode<T0>(&arg1);
        if (v0 == 1) {
            0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(518, 0, 915);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg1);
            return
        };
        let (v1, v2, v3, v4) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::h85f29<T0>(&arg1);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h5de86(v1, v2);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hb430b(&arg11, &arg12, &arg13);
        let v5 = 0x1::vector::length<u64>(&arg11);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h966c3(v5, &arg14, &arg17, arg15);
        let v6 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h78a5d(v5);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9ef43(&arg7, &mut v6);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9ef43(&arg8, &mut v6);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9ef43(&arg9, &mut v6);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9ef43(&arg10, &mut v6);
        let v7 = 0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::h4e71a(arg0, arg19);
        if (v0 == 2) {
            let v8 = &mut arg1;
            h11b51<T0>(v8, v7, arg2, arg3);
            0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(519, 0, 916);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg1);
            return
        };
        if (!0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h7f984::h32780<T0>(&mut arg1, v7, arg2, arg3, arg4, arg5, arg6)) {
            let v9 = &mut arg1;
            h11b51<T0>(v9, v7, arg2, arg3);
            0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(525, 0, 917);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg1);
            return
        };
        let v10 = 0x2::clock::timestamp_ms(arg6);
        let (v11, v12) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::hfa5fc<T0>(&arg1);
        let v13 = v12;
        let v14 = v11;
        let (v15, v16) = if (0x1::option::is_some<u64>(&arg18)) {
            0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::h50999<T0>(&arg1, *0x1::option::borrow<u64>(&arg18), 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::hd00a6(arg3), v10)
        } else {
            (vector[], vector[])
        };
        let v17 = v16;
        let v18 = v15;
        let v19 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::orderbook<T0>(&arg1);
        let v20 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h350bd(v19, 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h1a68c(arg3));
        let v21 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h350bd(v19, 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h1bb22(arg3));
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9a7dc(&mut v20, &arg8, &arg11, &arg12, &arg13, v10, v1, v2, true);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h9a7dc(&mut v21, &arg7, &arg11, &arg12, &arg13, v10, v1, v2, false);
        let v22 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h7f984::hb2e0b<T0>(&arg1, arg4, arg6);
        let v23 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::scaling_factor(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::market_params<T0>(&arg1));
        let (v24, v25) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h7f984::h635a1<T0>(&arg1, arg2, arg3, v22, v23, 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hecae9(&v20, v22), 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hecae9(&v21, v22));
        let v26 = v25;
        let v27 = v24;
        let v28 = vector[];
        let v29 = vector[];
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h60fb1(&mut v20, &arg9, &arg11, &arg12, &arg14, &arg17, &v18, arg15, arg16, v10, true, v1, &v14, &v13, v22, &mut v27, &mut v28, 918);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h60fb1(&mut v21, &arg10, &arg11, &arg12, &arg14, &arg17, &v17, arg15, arg16, v10, false, v1, &v14, &v13, v22, &mut v26, &mut v29, 918);
        let v30 = vector[];
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::he3d6c(&v20, 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h1a68c(arg3), &mut v30);
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::he3d6c(&v21, 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h1bb22(arg3), &mut v30);
        if (0x1::vector::length<u128>(&v30) > 0) {
            let v31 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::try_cancel_orders<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(&mut arg1, v7, arg2, &v30);
            0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h620fb(&v30, &v31);
        };
        let (v32, v33) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::hfa5fc<T0>(&arg1);
        let v34 = v33;
        let v35 = v32;
        let (v36, v37) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h7f984::h8adf6<T0>(&arg1, arg2, arg3, v22, v23);
        let v38 = v37;
        let v39 = v36;
        let (_, _, _, _, v44) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h552f1(arg3);
        let v45 = (v44 as u256) * v23;
        let v46 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hde79f(&arg7, true, &arg11, &arg12, &arg13, v10, v1, v2, v3, &v35, &v34, v22, &mut v39, 920);
        let v47 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hde79f(&arg8, false, &arg11, &arg12, &arg13, v10, v1, v2, v3, &v35, &v34, v22, &mut v38, 920);
        let v48 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hca436(&v28, true, &arg11, &arg12, &arg13, &arg17, &v18, v10, v1, v2, v3, &v35, &v34, v22, &mut v39, v45, 930);
        let v49 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hca436(&v29, false, &arg11, &arg12, &arg13, &arg17, &v17, v10, v1, v2, v3, &v35, &v34, v22, &mut v38, v45, 930);
        let v50 = h9f85c<T0>(&arg1, arg2, v4);
        let v51 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::hd5b68(arg3, true);
        let v52 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::hd5b68(arg3, false);
        let v53 = if (0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hfbcb3(&v46)) {
            true
        } else if (0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hfbcb3(&v47)) {
            true
        } else {
            v50 > 0 && (0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hfbcb3(&v48) && v51 > 0 || 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::hfbcb3(&v49) && v52 > 0)
        };
        if (!v53) {
            h7b932(&v28, &v48, v50, v51);
            h7b932(&v29, &v49, v50, v52);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(arg1);
            return
        };
        let v54 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::start_session<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg1, v7, arg2, arg4, arg5, 0x1::option::none<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::IntegratorInfo>(), arg6, arg19);
        let v55 = &mut v54;
        haf516<T0>(v55, &arg7, &v46, true, &arg11, &arg13);
        let v56 = &mut v54;
        haf516<T0>(v56, &arg8, &v47, false, &arg11, &arg13);
        let (v57, v58) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::hfa5fc<T0>(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::clearing_house<T0>(&v54));
        let v59 = v58;
        let v60 = v57;
        let (v61, v62) = ha6ec4(arg3);
        let v63 = v62;
        let v64 = v61;
        let v65 = &mut v54;
        let v66 = &mut v50;
        let v67 = &mut v64;
        let v68 = &mut v63;
        hf8703<T0>(v65, arg3, &v28, &v48, true, &arg11, &arg13, &arg17, &v18, v1, &v60, &v59, v66, v67, v68);
        let v69 = &mut v54;
        let v70 = &mut v50;
        let v71 = &mut v64;
        let v72 = &mut v63;
        hf8703<T0>(v69, arg3, &v29, &v49, false, &arg11, &arg13, &arg17, &v17, v1, &v60, &v59, v70, v71, v72);
        let (v73, v74) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::end_session<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(v54, v7, arg2, false, false);
        let v75 = v74;
        let v76 = v73;
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h145ed<T0>(&v76, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg2), &v75);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::share<T0>(v76);
    }

    fun h7b932(arg0: &vector<u64>, arg1: &0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::H2226f, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h47e0e(arg1, v0)) {
                if (arg2 == 0) {
                    0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(521, *0x1::vector::borrow<u64>(arg0, v0), 947);
                } else if (arg3 == 0) {
                    0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(528, *0x1::vector::borrow<u64>(arg0, v0), 947);
                };
                return
            };
            v0 = v0 + 1;
        };
    }

    fun h9f85c<T0>(arg0: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg1: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg2: u64) : u64 {
        let v0 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::account_id<T0>(arg1);
        if (!0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::exists_position<T0>(arg0, v0)) {
            return arg2
        };
        let v1 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::position<T0>(arg0, v0));
        if (arg2 > v1) {
            arg2 - v1
        } else {
            0
        }
    }

    fun ha6ec4(arg0: &0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::H032e6) : (u64, u64) {
        let (v0, v1) = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::ha3a8e(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::option::Option<u128>>(&v3)) {
            if (0x1::option::is_some<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(&v3, v6))) {
                let v7 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::h321c0(*0x1::option::borrow<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(&v3, v6)));
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
                let v11 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::h321c0(*0x1::option::borrow<u128>(0x1::vector::borrow<0x1::option::Option<u128>>(&v2, v10)));
                if (v11 < v8) {
                    v9 = v11;
                };
            };
            v10 = v10 + 1;
        };
        (v5, v9)
    }

    fun haf516<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionHotPotato<T0>, arg1: &vector<u64>, arg2: &0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::H2226f, arg3: bool, arg4: &vector<u64>, arg5: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            if (0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h47e0e(arg2, v0)) {
                let v1 = *0x1::vector::borrow<u64>(arg1, v0);
                hd61bf<T0>(arg0, arg3, 3, *0x1::vector::borrow<u64>(arg4, v1), 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h8befd(arg2, v0), *0x1::vector::borrow<u64>(arg5, v1));
            };
            v0 = v0 + 1;
        };
    }

    public fun hc6519<T0>(arg0: &0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::Ha4cb5, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg3: &mut 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::H032e6, arg4: &mut 0x2::tx_context::TxContext) {
        0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h295f4<T0>(arg3, arg2, arg1);
        h11b51<T0>(arg1, 0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::h4e71a(arg0, arg4), arg2, arg3);
    }

    fun hd61bf<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x1::option::Option<u128> {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::place_limit_order<T0>(arg0, !arg1, arg4, arg3, arg2, 0x1::option::none<u64>(), false, hde3eb(arg5))
    }

    public fun hdadbe<T0>(arg0: &0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::Ha4cb5, arg1: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::account::Account<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::create_market_position<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg1, 0x7e3afc5e9150deac85866146c352354fff0f5b1e1a3d44222b5d15b382bd3fdc::ha1781::h4e71a(arg0, arg3), arg2);
    }

    fun hde3eb(arg0: u64) : 0x1::option::Option<u64> {
        if (arg0 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0)
        }
    }

    fun hf8703<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::SessionHotPotato<T0>, arg1: &mut 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::H032e6, arg2: &vector<u64>, arg3: &0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::H2226f, arg4: bool, arg5: &vector<u64>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: &vector<u64>, arg9: u64, arg10: &0x1::option::Option<u64>, arg11: &0x1::option::Option<u64>, arg12: &mut u64, arg13: &mut u64, arg14: &mut u64) {
        let v0 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::hd5b68(arg1, arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg2)) {
            let v2 = v1;
            v1 = v1 + 1;
            if (!0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h47e0e(arg3, v2)) {
                continue
            };
            let v3 = *0x1::vector::borrow<u64>(arg2, v2);
            if (*arg12 == 0) {
                0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(521, v3, 945);
                return
            };
            if (v0 == 0) {
                0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h1ec67::h67a26(528, v3, 946);
                return
            };
            let v4 = 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::hb3f96(arg4, *0x1::vector::borrow<u64>(arg5, v3), 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h6fefe(arg3, v2), arg9, arg10, arg11, 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h5a57f::he2d3a(arg7, v3), arg8);
            if (arg4) {
                assert!(v4 < *arg14, 530);
            } else {
                assert!(v4 > *arg13, 530);
            };
            let v5 = hd61bf<T0>(arg0, arg4, 2, v4, 0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::hd4b1f::h8befd(arg3, v2), *0x1::vector::borrow<u64>(arg6, v3));
            if (0x1::option::is_some<u128>(&v5)) {
                0xb1c7b4f87779f1a3f13ffbbfd259cfdc91d1915ef2129c33809fb2c7a56ed291::h95cce::h644d5(arg1, arg4, 0x1::option::extract<u128>(&mut v5));
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

