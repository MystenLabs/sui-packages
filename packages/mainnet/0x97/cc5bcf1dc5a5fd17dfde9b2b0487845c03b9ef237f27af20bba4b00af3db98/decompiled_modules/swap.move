module 0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::swap {
    public entry fun unsafe_swap_sui_to_buck(arg0: &mut 0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::trust::Trust, arg1: &0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::trust::TrusteeCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg5: &0x2::clock::Clock) {
        let v0 = 0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::reserve::borrow<0x2::sui::SUI>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<0x2::sui::SUI>>(v0);
            if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
                0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_sui_to_buck(arg2, arg3, arg4, v1, arg5));
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v0);
        };
    }

    public entry fun unsafe_swap_xsui_to_buck<T0>(arg0: &mut 0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::trust::Trust, arg1: &0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::trust::TrusteeCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg6: &0x2::clock::Clock) {
        let v0 = 0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::reserve::borrow<T0>(arg0, arg1);
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v0)) {
            let v1 = 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v0);
            if (0x2::balance::value<T0>(&v1) > 0) {
                0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::reserve::repay<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, arg1, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_xsui_to_buck<T0>(arg2, arg3, arg4, arg5, v1, arg6));
            } else {
                0x2::balance::destroy_zero<T0>(v1);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

