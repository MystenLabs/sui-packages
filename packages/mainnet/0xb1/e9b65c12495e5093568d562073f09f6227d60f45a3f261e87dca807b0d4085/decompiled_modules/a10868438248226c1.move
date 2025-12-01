module 0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a10868438248226c1 {
    public(friend) fun a1b6a068cf2483ef2(arg0: u64, arg1: u64) : u64 {
        (arg0 + arg1 - 1) / arg1 * arg1
    }

    public fun a1f6a4f7ad3a8ae67(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : u64 {
        let (v0, _, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1, arg1);
        let v4 = v0;
        *0x1::vector::borrow<u64>(&v4, 0)
    }

    public(friend) fun a484231b6eaf0b5c2(arg0: u128) : bool {
        let (v0, _, _) = a726fc82fd84e5e03(arg0);
        v0
    }

    public fun a58713e7c1aa356b6(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 18446744073709551615, arg1)
    }

    public(friend) fun a726fc82fd84e5e03(arg0: u128) : (bool, u64, u64) {
        (arg0 >> 127 == 0, ((arg0 >> 64) as u64) & 9223372036854775807, ((arg0 & 18446744073709551615) as u64))
    }

    public(friend) fun a9d9f98ebd95b9dad(arg0: &0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::A0ea878587b719a64, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
        if (v0 < 0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::a2059360c1827f292(arg0)) {
            0
        } else {
            v0 - 0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::a2059360c1827f292(arg0)
        }
    }

    public fun a9e76fc27eca8fe95(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        (v0, v1)
    }

    public(friend) fun aa2c4ceebf26949f7(arg0: &0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::A0ea878587b719a64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg2 + abe7ab0b8cf6b9d08(arg0, arg1, arg3)
    }

    public(friend) fun ab78d0325509532d4(arg0: &0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::A0ea878587b719a64, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1);
        if (v0 < 0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::aa8d95a01d0a32dc8(arg0)) {
            0
        } else {
            v0 - 0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::aa8d95a01d0a32dc8(arg0)
        }
    }

    public(friend) fun abe7ab0b8cf6b9d08(arg0: &0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::A0ea878587b719a64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg2 as u128) / (0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::ad4b2d799016f877d(arg0) as u128)) as u64)
    }

    public(friend) fun ac1c7fe9ec84582bb(arg0: u128) : u64 {
        let (_, v1, _) = a726fc82fd84e5e03(arg0);
        v1
    }

    public(friend) fun ac89fc20276c7e30c(arg0: &0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::A0ea878587b719a64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (0xb1e9b65c12495e5093568d562073f09f6227d60f45a3f261e87dca807b0d4085::a783956f993d811bc::ad4b2d799016f877d(arg0) as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun ad3e462cd25333e7f(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg1 - arg0
        } else {
            arg0 - arg1
        }
    }

    public fun ad4fc943e554e945f(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1, arg1);
        let v4 = v2;
        let v5 = v0;
        (*0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v4, 0), 0x2::clock::timestamp_ms(arg1))
    }

    public(friend) fun add75d004ccb35065(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1 * arg1
    }

    public fun ae49887b64c6fb484(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &0x2::clock::Clock) : u64 {
        let (_, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 1, arg1);
        let v4 = v2;
        *0x1::vector::borrow<u64>(&v4, 0)
    }

    // decompiled from Move bytecode v6
}

