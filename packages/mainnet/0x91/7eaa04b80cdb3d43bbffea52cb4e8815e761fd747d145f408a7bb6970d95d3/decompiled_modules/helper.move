module 0x917eaa04b80cdb3d43bbffea52cb4e8815e761fd747d145f408a7bb6970d95d3::helper {
    fun assert_flat<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let (v1, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v0);
        assert!(v1 == 0 && 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v0) == 0, 0);
    }

    fun choose_maker_price<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64) : u64 {
        if (arg1 > 0) {
            arg1
        } else {
            let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(arg0, false);
            if (0x1::option::is_some<u64>(&v1)) {
                0x1::option::destroy_some<u64>(v1) + 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0))
            } else {
                0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0))
            }
        }
    }

    fun close_short<T0>(arg0: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let (v0, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(&arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg2)));
        let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v0), 1000000000);
        assert!(v2 > 0, 1);
        let v3 = start<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_market_order<T0>(&mut v3, false, v2, true);
        finish<T0>(v3, arg1, arg2)
    }

    fun finish<T0>(arg0: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let (v0, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0, arg1, arg2, true, false);
        v0
    }

    fun place<T0>(arg0: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext, arg7: bool, arg8: u64, arg9: u64, arg10: u64) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, 0x1::option::Option<u128>) {
        let v0 = start<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (finish<T0>(v0, arg1, arg2), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(&mut v0, arg7, arg8, arg9, arg10, 0x1::option::none<u64>(), false, 0x1::option::none<u64>()))
    }

    public fun run<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u256, arg16: bool, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) {
        let (v0, v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg18);
        let v3 = v2;
        let v4 = v0;
        let (v5, v6, v7) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg18);
        let v8 = v7;
        let v9 = v5;
        let (v10, v11, v12) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg18);
        let v13 = v12;
        let v14 = v10;
        let (v15, v16, v17) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg18);
        let v18 = v17;
        let v19 = v15;
        let (v20, v21, v22) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg18);
        let v23 = v22;
        let v24 = v20;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v3, &v4);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v8, &v9);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v13, &v14);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v18, &v19);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v23, &v24);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v3, &v4, arg15);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v8, &v9, arg15);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v13, &v14, arg15);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v18, &v19, arg15);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v23, &v24, arg15);
        let v25 = choose_maker_price<T0>(&arg1, arg13);
        if (arg8 > 0) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut v19, &v18, arg0, 0x2::coin::split<T0>(&mut arg4, arg7, arg18));
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut v24, &v23, arg0, 0x2::coin::split<T0>(&mut arg4, arg7, arg18));
            let v26 = &mut v19;
            let (v27, v28) = place<T0>(arg1, &v18, v26, arg2, arg3, arg17, arg18, true, arg8, v25, 3);
            arg1 = v27;
            0x1::option::destroy_none<u128>(v28);
            let v29 = &mut v24;
            let (v30, v31) = place<T0>(arg1, &v23, v29, arg2, arg3, arg17, arg18, true, arg8, v25, 3);
            arg1 = v30;
            0x1::option::destroy_none<u128>(v31);
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut v14, &v13, arg0, 0x2::coin::split<T0>(&mut arg4, arg10, arg18));
        if (arg11 > 0) {
            let v32 = &mut v14;
            let v33 = start<T0>(arg1, &v13, v32, arg2, arg3, arg17, arg18);
            while (arg11 > 0) {
                let v34 = if (arg11 > 50000000000) {
                    50000000000
                } else {
                    arg11
                };
                0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_market_order<T0>(&mut v33, true, v34, false);
                arg11 = arg11 - v34;
            };
            let v35 = &mut v14;
            let v36 = &mut v14;
            arg1 = close_short<T0>(finish<T0>(v33, &v13, v35), &v13, v36, arg2, arg3, arg17, arg18);
        };
        let v37 = if (arg8 > 0) {
            choose_maker_price<T0>(&arg1, 0)
        } else {
            choose_maker_price<T0>(&arg1, arg13)
        };
        let v38 = 0;
        while (v38 < arg5) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut v4, &v3, arg0, 0x2::coin::split<T0>(&mut arg4, arg6, arg18));
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut v9, &v8, arg0, 0x2::coin::split<T0>(&mut arg4, arg9, arg18));
            let v39 = &mut v4;
            let (v40, v41) = place<T0>(arg1, &v3, v39, arg2, arg3, arg17, arg18, true, arg12, v37, 2);
            arg1 = v40;
            0x1::option::destroy_some<u128>(v41);
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v3, &mut v4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(&v4));
            let v42 = &mut v14;
            let (v43, v44) = place<T0>(arg1, &v13, v42, arg2, arg3, arg17, arg18, false, arg12, arg14, 0);
            arg1 = v43;
            let v45 = 0x1::option::destroy_some<u128>(v44);
            if (arg16) {
                let v46 = 0x1::vector::empty<u128>();
                0x1::vector::push_back<u128>(&mut v46, v45);
                0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v13, &v14, v46);
            };
            let v47 = &mut v9;
            let (v48, v49) = place<T0>(arg1, &v8, v47, arg2, arg3, arg17, arg18, false, arg12, v37, 3);
            arg1 = v48;
            0x1::option::destroy_none<u128>(v49);
            if (!arg16) {
                let v50 = 0x1::vector::empty<u128>();
                0x1::vector::push_back<u128>(&mut v50, v45);
                0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::cancel_orders<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &v13, &v14, v50);
            };
            let v51 = &mut v9;
            let v52 = start<T0>(arg1, &v8, v51, arg2, arg3, arg17, arg18);
            let v53 = vector[];
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::liquidate<T0>(&mut v52, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(&v4), &v53);
            let v54 = &mut v9;
            arg1 = finish<T0>(v52, &v8, v54);
            let v55 = &mut arg1;
            let v56 = &mut v9;
            let v57 = withdraw_all<T0>(v55, &v8, v56, arg0, arg2, arg3, arg17, arg18);
            0x2::coin::join<T0>(&mut arg4, v57);
            v38 = v38 + 1;
        };
        let v58 = &mut arg1;
        let v59 = &mut v4;
        let v60 = withdraw_all<T0>(v58, &v3, v59, arg0, arg2, arg3, arg17, arg18);
        0x2::coin::join<T0>(&mut arg4, v60);
        let v61 = &mut arg1;
        let v62 = &mut v9;
        let v63 = withdraw_all<T0>(v61, &v8, v62, arg0, arg2, arg3, arg17, arg18);
        0x2::coin::join<T0>(&mut arg4, v63);
        let v64 = &mut arg1;
        let v65 = &mut v14;
        let v66 = withdraw_all<T0>(v64, &v13, v65, arg0, arg2, arg3, arg17, arg18);
        0x2::coin::join<T0>(&mut arg4, v66);
        let v67 = &mut arg1;
        let v68 = &mut v19;
        let v69 = withdraw_all<T0>(v67, &v18, v68, arg0, arg2, arg3, arg17, arg18);
        0x2::coin::join<T0>(&mut arg4, v69);
        let v70 = &mut arg1;
        let v71 = &mut v24;
        let v72 = withdraw_all<T0>(v70, &v23, v71, arg0, arg2, arg3, arg17, arg18);
        0x2::coin::join<T0>(&mut arg4, v72);
        assert_flat<T0>(&arg1, &v4);
        assert_flat<T0>(&arg1, &v9);
        assert_flat<T0>(&arg1, &v14);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T0>(v4, v1);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T0>(v9, v6);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T0>(v14, v11);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T0>(v19, v16);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T0>(v24, v21);
        let v73 = 0x2::tx_context::sender(arg18);
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>>(v3, v73);
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>>(v8, v73);
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>>(v13, v73);
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>>(v18, v73);
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>>(v23, v73);
        (arg4, arg1)
    }

    fun start<T0>(arg0: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0> {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg5, arg6)
    }

    fun withdraw_all<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_free_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0, arg1, arg2, arg4, arg5, arg6);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T0>(arg2, arg1, arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg2), arg7)
    }

    // decompiled from Move bytecode v7
}

