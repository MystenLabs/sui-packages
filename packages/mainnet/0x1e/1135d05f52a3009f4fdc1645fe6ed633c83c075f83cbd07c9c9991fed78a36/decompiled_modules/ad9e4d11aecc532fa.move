module 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::ad9e4d11aecc532fa {
    public(friend) fun a1134e088837aa9d7(arg0: u128, arg1: u64) : u128 {
        let v0 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000050000 / 1000000000;
            if (v0 > (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000024999;
            v1 = v2 / 1000000000;
        };
        (v1 as u128)
    }

    public(friend) fun a34a6cb13f0f0ba27(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (1000000000 as u128) / (arg0 as u128)) as u64)
    }

    public(friend) fun a3cd6d91ca7350f3f(arg0: &0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::A0ea878587b719a64, arg1: &0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::A8eaa8c1bdbc9ed0a, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: bool) : u64 {
        if (arg5 && arg3 >= arg4) {
            return 0
        };
        if (!arg5 && arg3 <= arg4) {
            return 0
        };
        let v0 = 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a10868438248226c1::ad3e462cd25333e7f(arg3, arg4) * 1000 / arg4 / 10000;
        if (v0 < 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0)) {
            return 0
        };
        0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a1c61f525b4283a20::a2719df4ae928c371(arg1, arg0, arg2, 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a7e35067d3a47eeae(arg0) + 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a3710772f3b618373(arg0) * (v0 - 0x1e1135d05f52a3009f4fdc1645fe6ed633c83c075f83cbd07c9c9991fed78a36::a783956f993d811bc::a082bc5b19227e420(arg0)) / 1000, arg5)
    }

    public(friend) fun a8e0f142d42cfb97e(arg0: u128, arg1: u64) : u128 {
        let v0 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000000000 / 1000050000;
            if (v0 < (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000000000;
            v1 = v2 / 1000024999;
        };
        (v1 as u128)
    }

    public(friend) fun a9706b71488d40615() : u64 {
        1
    }

    public(friend) fun acde36a6fa6c393c2(arg0: u128, arg1: u64) : u128 {
        let v0 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000050000 / 1000000000;
            if (v0 > (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000000000;
            v1 = v2 / 1000024999;
        };
        (v1 as u128)
    }

    public(friend) fun ae0a2f8b7674831a4() : u64 {
        0
    }

    public(friend) fun aee479d24be81fbe9(arg0: u128, arg1: u64) : u128 {
        let v0 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v1 = (arg0 as u256);
        loop {
            v0 = v0 * 1000000000 / 1000050000;
            if (v0 < (arg1 as u256) * 1000000000) {
                break
            };
            let v2 = v1 * 1000024999;
            v1 = v2 / 1000000000;
        };
        (v1 as u128)
    }

    public(friend) fun af95ffd01d13caab1() : u64 {
        3
    }

    public(friend) fun afe80a6b6b615d930() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

