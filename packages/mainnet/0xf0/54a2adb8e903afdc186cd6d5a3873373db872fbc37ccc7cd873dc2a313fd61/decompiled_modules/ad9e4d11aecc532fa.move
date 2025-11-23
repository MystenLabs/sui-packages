module 0xf054a2adb8e903afdc186cd6d5a3873373db872fbc37ccc7cd873dc2a313fd61::ad9e4d11aecc532fa {
    struct Ad1f26f3c041612f2 has store {
        a817c3e383e2f23d1: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
    }

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

    public(friend) fun a75d4519aec44b4ef() : Ad1f26f3c041612f2 {
        Ad1f26f3c041612f2{a817c3e383e2f23d1: 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>()}
    }

    public(friend) fun a817c3e383e2f23d1(arg0: &mut Ad1f26f3c041612f2) : &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        &mut arg0.a817c3e383e2f23d1
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

    public(friend) fun a987991451fdafffc(arg0: &mut Ad1f26f3c041612f2, arg1: address) {
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.a817c3e383e2f23d1), arg1);
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

