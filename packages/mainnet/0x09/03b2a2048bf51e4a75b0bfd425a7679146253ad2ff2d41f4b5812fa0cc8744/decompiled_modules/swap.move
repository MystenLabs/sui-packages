module 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::swap {
    public entry fun unsafe_swap_sui_to_buck(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg5: &0x2::clock::Clock) {
        let v0 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::borrow<0x2::sui::SUI>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<0x2::sui::SUI>>(v0);
            if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
                0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x5087b0c88a90ece5b83f6f4397f6fc60910f4f4494baacff14f687cbdf017b00::cetus::unsafe_swap_sui_to_buck(arg2, arg3, arg4, v1, arg5));
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v0);
        };
    }

    public entry fun unsafe_swap_sui_to_buck_by_psm(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        let v0 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::borrow<0x2::sui::SUI>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<0x2::sui::SUI>>(v0);
            if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
                0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x5087b0c88a90ece5b83f6f4397f6fc60910f4f4494baacff14f687cbdf017b00::cetus::unsafe_swap_sui_to_buck_by_psm(arg3, arg2, arg4, v1, arg5));
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v0);
        };
    }

    public entry fun unsafe_swap_sui_to_buck_by_psm_and_circle(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        let v0 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::borrow<0x2::sui::SUI>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<0x2::sui::SUI>>(v0);
            if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
                0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x690fecc7ec0320ccfa5de366f201a520e69c9a17af9c20abb3ae4252972d6d67::cetus_v2::unsafe_swap_sui_to_buck_by_psm(arg3, arg2, arg4, v1, arg5));
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v0);
        };
    }

    public entry fun unsafe_swap_xsui_to_buck<T0>(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg6: &0x2::clock::Clock) {
        let v0 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::borrow<T0>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v0);
            if (0x2::balance::value<T0>(&v1) > 0) {
                0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x5087b0c88a90ece5b83f6f4397f6fc60910f4f4494baacff14f687cbdf017b00::cetus::unsafe_swap_xsui_to_buck<T0>(arg2, arg3, arg4, arg5, v1, arg6));
            } else {
                0x2::balance::destroy_zero<T0>(v1);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v0);
        };
    }

    public entry fun unsafe_swap_xsui_to_buck_by_psm<T0>(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        let v0 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::borrow<T0>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v0);
            if (0x2::balance::value<T0>(&v1) > 0) {
                0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x5087b0c88a90ece5b83f6f4397f6fc60910f4f4494baacff14f687cbdf017b00::cetus::unsafe_swap_xsui_to_buck_by_psm<T0>(arg3, arg2, arg4, arg5, v1, arg6));
            } else {
                0x2::balance::destroy_zero<T0>(v1);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v0);
        };
    }

    public entry fun unsafe_swap_xsui_to_buck_by_psm_and_circle<T0>(arg0: &mut 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::Trust, arg1: &0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::trust::TrusteeCap, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &0x2::clock::Clock) {
        let v0 = 0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::borrow<T0>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v0);
            if (0x2::balance::value<T0>(&v1) > 0) {
                0x404a020a3b44456ce13a7838b02d41431acfc3afe2f035cabcf1ab11b8dfe797::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x690fecc7ec0320ccfa5de366f201a520e69c9a17af9c20abb3ae4252972d6d67::cetus_v2::unsafe_swap_xsui_to_buck_by_psm<T0>(arg3, arg2, arg4, arg5, v1, arg6));
            } else {
                0x2::balance::destroy_zero<T0>(v1);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

