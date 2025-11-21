module 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2f7a3f8250aae687 {
    struct Aa4652e2da86fbb61 has copy, drop {
        ac7f210fc32637b79: bool,
        pool: 0x1::string::String,
        aefb8102bf036ff88: u64,
        a8108687c4de4ea83: u128,
        a300f5009218579d6: u128,
        a44bce80f10717132: bool,
        ada1b3c8a2397a876: bool,
    }

    struct Ae5270409c4a31d29 has copy, drop {
        a31f11751781e6c71: u64,
        a9df70c4191cc59c8: u64,
        ac7f210fc32637b79: bool,
        pool: 0x1::string::String,
        a1c7efc41c3937d9d: u64,
        a7d027a58611a0718: 0x2::object::ID,
    }

    struct A44dc07697c5e5041 has copy, drop {
        price: u64,
        a4c9f6a30dfcb26d4: u64,
    }

    struct Ab0784991b4b97608 has copy, drop {
        aab80f1dc57a77584: vector<A44dc07697c5e5041>,
        a8ea67a9d479b4cc3: vector<A44dc07697c5e5041>,
        a888bd220dbabe932: vector<Aa4652e2da86fbb61>,
        a1c7efc41c3937d9d: u64,
    }

    public(friend) fun adc6afbc22cb36f39(arg0: &0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: u64, arg14: &mut u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        if (!0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::ada14a7c9727063c9(arg0)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg15) < *arg14 + 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::ae9a4ee60c1c9da40(arg0)) {
            return
        };
        let v0 = 0x1::vector::empty<A44dc07697c5e5041>();
        let v1 = 0x1::vector::empty<A44dc07697c5e5041>();
        let v2 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::ae0a2f8b7674831a4();
        let v3 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a099d08408fdb4a75();
        let (v4, v5) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(&v3, arg6);
        let v6 = A44dc07697c5e5041{
            price             : v4,
            a4c9f6a30dfcb26d4 : v2,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v6);
        let v7 = A44dc07697c5e5041{
            price             : v5,
            a4c9f6a30dfcb26d4 : v2,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v7);
        let v8 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a9706b71488d40615();
        let v9 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a099d08408fdb4a75();
        let (v10, v11) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(&v9, arg4);
        let v12 = A44dc07697c5e5041{
            price             : v10,
            a4c9f6a30dfcb26d4 : v8,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v12);
        let v13 = A44dc07697c5e5041{
            price             : v11,
            a4c9f6a30dfcb26d4 : v8,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v13);
        let v14 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::afe80a6b6b615d930();
        let v15 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a099d08408fdb4a75();
        let (v16, v17) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::ae3e8a1f78ac1be2d(&v15, arg8);
        let v18 = A44dc07697c5e5041{
            price             : v16,
            a4c9f6a30dfcb26d4 : v14,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v18);
        let v19 = A44dc07697c5e5041{
            price             : v17,
            a4c9f6a30dfcb26d4 : v14,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v19);
        let v20 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::af95ffd01d13caab1();
        let v21 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a099d08408fdb4a75();
        let (v22, v23) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::ae3e8a1f78ac1be2d(&v21, arg10);
        let v24 = A44dc07697c5e5041{
            price             : v22,
            a4c9f6a30dfcb26d4 : v20,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v0, v24);
        let v25 = A44dc07697c5e5041{
            price             : v23,
            a4c9f6a30dfcb26d4 : v20,
        };
        0x1::vector::push_back<A44dc07697c5e5041>(&mut v1, v25);
        let v26 = Ab0784991b4b97608{
            aab80f1dc57a77584 : v0,
            a8ea67a9d479b4cc3 : v1,
            a888bd220dbabe932 : 0x1::vector::empty<Aa4652e2da86fbb61>(),
            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg15),
        };
        let v27 = &mut v0;
        let v28 = 0x1::vector::length<A44dc07697c5e5041>(v27);
        if (v28 <= 1) {
        } else {
            let v29 = 0;
            while (v29 < v28) {
                let v30 = 0;
                let v31 = false;
                while (v30 < v28 - v29 - 1) {
                    let v32 = 0x1::vector::borrow<A44dc07697c5e5041>(v27, v30);
                    let v33 = 0x1::vector::borrow<A44dc07697c5e5041>(v27, v30 + 1);
                    let v34 = *v32;
                    let v35 = *v33;
                    if (!(v34.price > v35.price)) {
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v27, v30) = *v33;
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v27, v30 + 1) = *v32;
                        v31 = true;
                    };
                    v30 = v30 + 1;
                };
                if (!v31) {
                    break
                };
                v29 = v29 + 1;
            };
        };
        let v36 = &mut v1;
        let v37 = 0x1::vector::length<A44dc07697c5e5041>(v36);
        if (v37 <= 1) {
        } else {
            let v38 = 0;
            while (v38 < v37) {
                let v39 = 0;
                let v40 = false;
                while (v39 < v37 - v38 - 1) {
                    let v41 = 0x1::vector::borrow<A44dc07697c5e5041>(v36, v39);
                    let v42 = 0x1::vector::borrow<A44dc07697c5e5041>(v36, v39 + 1);
                    let v43 = *v41;
                    let v44 = *v42;
                    if (!(v43.price < v44.price)) {
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v36, v39) = *v42;
                        *0x1::vector::borrow_mut<A44dc07697c5e5041>(v36, v39 + 1) = *v41;
                        v40 = true;
                    };
                    v39 = v39 + 1;
                };
                if (!v40) {
                    break
                };
                v38 = v38 + 1;
            };
        };
        let v45 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000;
        if (0x1::vector::borrow<A44dc07697c5e5041>(&v0, 0).price + v45 > arg13 && 0x1::vector::borrow<A44dc07697c5e5041>(&v1, 0).price < arg13 + v45) {
            0x2::event::emit<Ab0784991b4b97608>(v26);
            return
        };
        let v46 = &v0;
        let v47 = 0;
        while (v47 < 0x1::vector::length<A44dc07697c5e5041>(v46)) {
            let v48 = 0x1::vector::borrow<A44dc07697c5e5041>(v46, v47);
            if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::aabf49d2de82cae44(arg0) && v48.price + v45 <= arg13) {
                let v49 = afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v48.a4c9f6a30dfcb26d4, true, arg15, arg16);
                0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v26.a888bd220dbabe932, v49);
            };
            v47 = v47 + 1;
        };
        let v50 = &v1;
        let v51 = 0;
        while (v51 < 0x1::vector::length<A44dc07697c5e5041>(v50)) {
            let v52 = 0x1::vector::borrow<A44dc07697c5e5041>(v50, v51);
            if (v52.price >= arg13 + v45) {
                0x1::vector::push_back<Aa4652e2da86fbb61>(&mut v26.a888bd220dbabe932, afc08853f58c750bf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v52.a4c9f6a30dfcb26d4, false, arg15, arg16));
            };
            v51 = v51 + 1;
        };
        let v53 = &v26.a888bd220dbabe932;
        let v54 = 0;
        while (v54 < 0x1::vector::length<Aa4652e2da86fbb61>(v53)) {
            if (0x1::vector::borrow<Aa4652e2da86fbb61>(v53, v54).ada1b3c8a2397a876) {
                *arg14 = 0x2::clock::timestamp_ms(arg15);
            };
            v54 = v54 + 1;
        };
        0x2::event::emit<Ab0784991b4b97608>(v26);
    }

    fun afc08853f58c750bf(arg0: &0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::A0ea878587b719a64, arg1: &mut 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: u64, arg14: u64, arg15: bool, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : Aa4652e2da86fbb61 {
        if (arg14 == 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::ae0a2f8b7674831a4()) {
            let v1 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a099d08408fdb4a75();
            if (arg15) {
                let v2 = &v1;
                let v3 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : true,
                    pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a29522d5809d7e86e(v2),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v2, arg6),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v4 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000;
                let v5 = arg13 - v4 - arg13 * 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::get_fee_rate(v2, arg6) / 1000000;
                v3.aefb8102bf036ff88 = v5;
                let v6 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::ac019152139aa990a(v2, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v2, arg6), v5);
                v3.a8108687c4de4ea83 = v6;
                if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v2) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v2, arg6) >= v6 || !0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v2) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v2, arg6) <= v6) {
                    v3
                } else {
                    let (v7, _) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v2, arg6);
                    let v9 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v7, arg13, true);
                    let v10 = v9;
                    let v11 = arg13 - v4;
                    0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg12, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v9, v11), arg16, arg17);
                    let v12 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v11);
                    if (v9 > v12) {
                        v10 = v12;
                    };
                    if (v10 < 1 * 1000000000) {
                        v3.a44bce80f10717132 = true;
                        v3
                    } else {
                        let (v13, v14) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a44e5f8062dd6fde6(v2, arg2, arg6, arg7, v10, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v10, v11), v6, arg16, arg17);
                        let v15 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v13,
                            a9df70c4191cc59c8 : v14,
                            ac7f210fc32637b79 : true,
                            pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a29522d5809d7e86e(v2),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg16),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v15);
                        v3.ada1b3c8a2397a876 = true;
                        v3
                    }
                }
            } else {
                let v16 = &v1;
                let v17 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : false,
                    pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a29522d5809d7e86e(v16),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v16, arg6),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v18 = arg13 + 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000 + arg13 * 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::get_fee_rate(v16, arg6) / 1000000;
                v17.aefb8102bf036ff88 = v18;
                let v19 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a213fd2a6b463b66d(v16, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v16, arg6), v18);
                v17.a8108687c4de4ea83 = v19;
                if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v16) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v16, arg6) <= v19 || !0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a3bf20a19fec6c3ca(v16) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(v16, arg6) >= v19) {
                    v17
                } else {
                    let (_, v21) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::ae3e8a1f78ac1be2d(v16, arg6);
                    let v22 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v21, arg13, false);
                    let v23 = v22;
                    0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg12, v22, arg16, arg17);
                    let v24 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                    if (v22 > v24) {
                        v23 = v24;
                    };
                    if (v23 < 1 * 1000000000) {
                        v17.a44bce80f10717132 = true;
                        v17
                    } else {
                        let (v25, v26) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::af81a08da76e37dc0(v16, arg2, arg6, arg7, v23, v19, arg16, arg17);
                        let v27 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v25,
                            a9df70c4191cc59c8 : v26,
                            ac7f210fc32637b79 : false,
                            pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a2ec4300f6df080d1::a29522d5809d7e86e(v16),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg16),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v27);
                        v17.ada1b3c8a2397a876 = true;
                        v17
                    }
                }
            }
        } else if (arg14 == 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a9706b71488d40615()) {
            let v28 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a099d08408fdb4a75();
            if (arg15) {
                let v29 = &v28;
                let v30 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : true,
                    pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a29522d5809d7e86e(v29),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v29, arg4),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v31 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000;
                let v32 = arg13 - v31 - arg13 * 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::get_fee_rate(v29, arg4) / 1000000;
                v30.aefb8102bf036ff88 = v32;
                let v33 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::ac019152139aa990a(v29, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v29, arg4), v32);
                v30.a8108687c4de4ea83 = v33;
                if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v29) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v29, arg4) >= v33 || !0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v29) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v29, arg4) <= v33) {
                    v30
                } else {
                    let (v34, _) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(v29, arg4);
                    let v36 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v34, arg13, true);
                    let v37 = v36;
                    let v38 = arg13 - v31;
                    0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg12, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v36, v38), arg16, arg17);
                    let v39 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v38);
                    if (v36 > v39) {
                        v37 = v39;
                    };
                    if (v37 < 1 * 1000000000) {
                        v30.a44bce80f10717132 = true;
                        v30
                    } else {
                        let (v40, v41) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a44e5f8062dd6fde6(v29, arg2, arg4, arg5, v37, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v37, v38), v33, arg16, arg17);
                        let v42 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v40,
                            a9df70c4191cc59c8 : v41,
                            ac7f210fc32637b79 : true,
                            pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a29522d5809d7e86e(v29),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg16),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v42);
                        v30.ada1b3c8a2397a876 = true;
                        v30
                    }
                }
            } else {
                let v43 = &v28;
                let v44 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : false,
                    pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a29522d5809d7e86e(v43),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v43, arg4),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v45 = arg13 + 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000 + arg13 * 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::get_fee_rate(v43, arg4) / 1000000;
                v44.aefb8102bf036ff88 = v45;
                let v46 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a213fd2a6b463b66d(v43, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v43, arg4), v45);
                v44.a8108687c4de4ea83 = v46;
                if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v43) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v43, arg4) <= v46 || !0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a3bf20a19fec6c3ca(v43) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a8a8b4bfff2e7f9e6(v43, arg4) >= v46) {
                    v44
                } else {
                    let (_, v48) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::ae3e8a1f78ac1be2d(v43, arg4);
                    let v49 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v48, arg13, false);
                    let v50 = v49;
                    0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg12, v49, arg16, arg17);
                    let v51 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                    if (v49 > v51) {
                        v50 = v51;
                    };
                    if (v50 < 1 * 1000000000) {
                        v44.a44bce80f10717132 = true;
                        v44
                    } else {
                        let (v52, v53) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::af81a08da76e37dc0(v43, arg2, arg4, arg5, v50, v46, arg16, arg17);
                        let v54 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v52,
                            a9df70c4191cc59c8 : v53,
                            ac7f210fc32637b79 : false,
                            pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::aa3c3c838649f8f32::a29522d5809d7e86e(v43),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg16),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v54);
                        v44.ada1b3c8a2397a876 = true;
                        v44
                    }
                }
            }
        } else if (arg14 == 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::afe80a6b6b615d930()) {
            let v55 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a099d08408fdb4a75();
            if (arg15) {
                let v56 = &v55;
                let v57 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : true,
                    pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a29522d5809d7e86e(v56),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v56, arg8),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v58 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000;
                let v59 = arg13 - v58 - arg13 * 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::get_fee_rate(v56, arg8) / 1000000;
                v57.aefb8102bf036ff88 = v59;
                let v60 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::ac019152139aa990a(v56, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v56, arg8), v59);
                v57.a8108687c4de4ea83 = v60;
                if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a3bf20a19fec6c3ca(v56) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v56, arg8) >= v60 || !0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a3bf20a19fec6c3ca(v56) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v56, arg8) <= v60) {
                    v57
                } else {
                    let (v61, _) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::ae3e8a1f78ac1be2d(v56, arg8);
                    let v63 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v61, arg13, true);
                    let v64 = v63;
                    let v65 = arg13 - v58;
                    0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg12, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v63, v65), arg16, arg17);
                    let v66 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v65);
                    if (v63 > v66) {
                        v64 = v66;
                    };
                    if (v64 < 1 * 1000000000) {
                        v57.a44bce80f10717132 = true;
                        v57
                    } else {
                        let (v67, v68) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a44e5f8062dd6fde6(v56, arg2, arg8, arg9, v64, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v64, v65), v60, arg16, arg17);
                        let v69 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v67,
                            a9df70c4191cc59c8 : v68,
                            ac7f210fc32637b79 : true,
                            pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a29522d5809d7e86e(v56),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg16),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v69);
                        v57.ada1b3c8a2397a876 = true;
                        v57
                    }
                }
            } else {
                let v70 = &v55;
                let v71 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : false,
                    pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a29522d5809d7e86e(v70),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v70, arg8),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v72 = arg13 + 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000 + arg13 * 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::get_fee_rate(v70, arg8) / 1000000;
                v71.aefb8102bf036ff88 = v72;
                let v73 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a213fd2a6b463b66d(v70, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v70, arg8), v72);
                v71.a8108687c4de4ea83 = v73;
                if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a3bf20a19fec6c3ca(v70) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v70, arg8) <= v73 || !0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a3bf20a19fec6c3ca(v70) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a8a8b4bfff2e7f9e6(v70, arg8) >= v73) {
                    v71
                } else {
                    let (_, v75) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::ae3e8a1f78ac1be2d(v70, arg8);
                    let v76 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v75, arg13, false);
                    let v77 = v76;
                    0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg12, v76, arg16, arg17);
                    let v78 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                    if (v76 > v78) {
                        v77 = v78;
                    };
                    if (v77 < 1 * 1000000000) {
                        v71.a44bce80f10717132 = true;
                        v71
                    } else {
                        let (v79, v80) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::af81a08da76e37dc0(v70, arg2, arg8, arg9, v77, v73, arg16, arg17);
                        let v81 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v79,
                            a9df70c4191cc59c8 : v80,
                            ac7f210fc32637b79 : false,
                            pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a3029a63d54b9410b::a29522d5809d7e86e(v70),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg16),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v81);
                        v71.ada1b3c8a2397a876 = true;
                        v71
                    }
                }
            }
        } else {
            assert!(arg14 == 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::af95ffd01d13caab1(), 13906836089898795007);
            let v82 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a099d08408fdb4a75();
            if (arg15) {
                let v83 = &v82;
                let v84 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : true,
                    pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a29522d5809d7e86e(v83),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v83, arg10),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v85 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000;
                let v86 = arg13 - v85 - arg13 * 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::get_fee_rate(v83, arg10) / 1000000;
                v84.aefb8102bf036ff88 = v86;
                let v87 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::ac019152139aa990a(v83, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v83, arg10), v86);
                v84.a8108687c4de4ea83 = v87;
                if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a3bf20a19fec6c3ca(v83) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v83, arg10) >= v87 || !0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a3bf20a19fec6c3ca(v83) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v83, arg10) <= v87) {
                    v84
                } else {
                    let (v88, _) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::ae3e8a1f78ac1be2d(v83, arg10);
                    let v90 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v88, arg13, true);
                    let v91 = v90;
                    let v92 = arg13 - v85;
                    0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a7b7e6cc5534d020a(arg1, arg0, arg2, arg3, arg12, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v90, v92), arg16, arg17);
                    let v93 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ac89fc20276c7e30c(arg0, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::a9d9f98ebd95b9dad(arg0, arg2), v92);
                    if (v90 > v93) {
                        v91 = v93;
                    };
                    if (v91 < 1 * 1000000000) {
                        v84.a44bce80f10717132 = true;
                        v84
                    } else {
                        let (v94, v95) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a44e5f8062dd6fde6(v83, arg2, arg10, arg11, v91, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::abe7ab0b8cf6b9d08(arg0, v91, v92), v87, arg16, arg17);
                        let v96 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v94,
                            a9df70c4191cc59c8 : v95,
                            ac7f210fc32637b79 : true,
                            pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a29522d5809d7e86e(v83),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg16),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v96);
                        v84.ada1b3c8a2397a876 = true;
                        v84
                    }
                }
            } else {
                let v97 = &v82;
                let v98 = Aa4652e2da86fbb61{
                    ac7f210fc32637b79 : false,
                    pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a29522d5809d7e86e(v97),
                    aefb8102bf036ff88 : 0,
                    a8108687c4de4ea83 : 0,
                    a300f5009218579d6 : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v97, arg10),
                    a44bce80f10717132 : false,
                    ada1b3c8a2397a876 : false,
                };
                let v99 = arg13 + 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0) * arg13 / 10000 / 1000 + arg13 * 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::get_fee_rate(v97, arg10) / 1000000;
                v98.aefb8102bf036ff88 = v99;
                let v100 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a213fd2a6b463b66d(v97, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v97, arg10), v99);
                v98.a8108687c4de4ea83 = v100;
                if (0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a3bf20a19fec6c3ca(v97) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v97, arg10) <= v100 || !0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a3bf20a19fec6c3ca(v97) && 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a8a8b4bfff2e7f9e6(v97, arg10) >= v100) {
                    v98
                } else {
                    let (_, v102) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::ae3e8a1f78ac1be2d(v97, arg10);
                    let v103 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa::a3cd6d91ca7350f3f(arg0, arg1, arg2, v102, arg13, false);
                    let v104 = v103;
                    0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a7e4799d1951fe624(arg1, arg0, arg2, arg3, arg12, v103, arg16, arg17);
                    let v105 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ab78d0325509532d4(arg0, arg2);
                    if (v103 > v105) {
                        v104 = v105;
                    };
                    if (v104 < 1 * 1000000000) {
                        v98.a44bce80f10717132 = true;
                        v98
                    } else {
                        let (v106, v107) = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::af81a08da76e37dc0(v97, arg2, arg10, arg11, v104, v100, arg16, arg17);
                        let v108 = Ae5270409c4a31d29{
                            a31f11751781e6c71 : v106,
                            a9df70c4191cc59c8 : v107,
                            ac7f210fc32637b79 : false,
                            pool              : 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a96046ed7ec86c084::a29522d5809d7e86e(v97),
                            a1c7efc41c3937d9d : 0x2::clock::timestamp_ms(arg16),
                            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2),
                        };
                        0x2::event::emit<Ae5270409c4a31d29>(v108);
                        v98.ada1b3c8a2397a876 = true;
                        v98
                    }
                }
            }
        }
    }

    // decompiled from Move bytecode v6
}

