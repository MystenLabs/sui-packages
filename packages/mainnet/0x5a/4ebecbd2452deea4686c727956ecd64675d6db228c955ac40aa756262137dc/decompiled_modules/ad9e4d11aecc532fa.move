module 0x5a4ebecbd2452deea4686c727956ecd64675d6db228c955ac40aa756262137dc::ad9e4d11aecc532fa {
    struct Ab258602200a3899b has copy, drop, store {
        ab831404733ad15a2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        a06096f5efca1025e: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        a2d2b06468676bab5: u64,
        a07220bc61fe480d4: u64,
        aafcb7cf7946a0bfd: u128,
    }

    struct Adcace4a70f0f34a4 has copy, drop {
        pool: 0x1::string::String,
        a2d2b06468676bab5: u64,
        a07220bc61fe480d4: u64,
        a5e2634f0e666a7a1: u64,
        ae273b39a0a3f5397: u64,
        a804f906337f5c9c4: u64,
        a963225d1fa28f7c6: u64,
        a64ae17ef03999f5b: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct Ad1f26f3c041612f2 has store {
        a0adedbbdb2e7ecef: Ab258602200a3899b,
        a3c5cbfe902e7eac6: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        ac1087ea8a474f669: Ab258602200a3899b,
        a66f312e9410a93e8: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        a2badf5b190b0ab8c: Ab258602200a3899b,
        aaa8080f103d8e1de: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>,
    }

    public(friend) fun a0adedbbdb2e7ecef(arg0: &mut Ad1f26f3c041612f2) : &mut Ab258602200a3899b {
        &mut arg0.a0adedbbdb2e7ecef
    }

    public fun a0fe3f4b34897c4e5(arg0: &mut Ad1f26f3c041612f2) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        arg0.a2badf5b190b0ab8c = a2c9b8f77fb19b963();
        0x1::option::extract<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg0.aaa8080f103d8e1de)
    }

    public(friend) fun a1134e088837aa9d7(arg0: u128, arg1: u64) : u128 {
        let v0 = (arg1 as u256) * 1000000000;
        let v1 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v2 = (arg0 as u256);
        loop {
            let v3 = v1 * 1001000000 / 1000000000;
            if (v3 > v0) {
                break
            };
            let v4 = v2 * 1000499875;
            v2 = v4 / 1000000000;
            v1 = v3;
        };
        loop {
            let v5 = v1 * 1000050000 / 1000000000;
            if (v5 > v0) {
                break
            };
            let v6 = v2 * 1000024999;
            v2 = v6 / 1000000000;
            v1 = v5;
        };
        (v2 as u128)
    }

    public(friend) fun a21b8c64204576499(arg0: &Ab258602200a3899b) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.a06096f5efca1025e
    }

    public(friend) fun a280ecc58e70fd664(arg0: &Ad1f26f3c041612f2) : (u64, u64) {
        (0 + arg0.a0adedbbdb2e7ecef.a07220bc61fe480d4 + arg0.ac1087ea8a474f669.a07220bc61fe480d4 + arg0.a2badf5b190b0ab8c.a07220bc61fe480d4, 0 + arg0.a0adedbbdb2e7ecef.a2d2b06468676bab5 + arg0.ac1087ea8a474f669.a2d2b06468676bab5 + arg0.a2badf5b190b0ab8c.a2d2b06468676bab5)
    }

    public(friend) fun a2badf5b190b0ab8c(arg0: &mut Ad1f26f3c041612f2) : &mut Ab258602200a3899b {
        &mut arg0.a2badf5b190b0ab8c
    }

    public(friend) fun a2c9b8f77fb19b963() : Ab258602200a3899b {
        Ab258602200a3899b{
            ab831404733ad15a2 : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0),
            a06096f5efca1025e : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0),
            a2d2b06468676bab5 : 0,
            a07220bc61fe480d4 : 0,
            aafcb7cf7946a0bfd : 0,
        }
    }

    public(friend) fun a34a6cb13f0f0ba27(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (1000000000 as u128) / (arg0 as u128)) as u64)
    }

    public(friend) fun a3c5cbfe902e7eac6(arg0: &mut Ad1f26f3c041612f2) : &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        &mut arg0.a3c5cbfe902e7eac6
    }

    public fun a644a394872f1c524(arg0: &mut Ad1f26f3c041612f2) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        arg0.ac1087ea8a474f669 = a2c9b8f77fb19b963();
        0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.a66f312e9410a93e8)
    }

    public(friend) fun a66f312e9410a93e8(arg0: &mut Ad1f26f3c041612f2) : &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        &mut arg0.a66f312e9410a93e8
    }

    public(friend) fun a75d4519aec44b4ef() : Ad1f26f3c041612f2 {
        Ad1f26f3c041612f2{
            a0adedbbdb2e7ecef : a2c9b8f77fb19b963(),
            a3c5cbfe902e7eac6 : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            ac1087ea8a474f669 : a2c9b8f77fb19b963(),
            a66f312e9410a93e8 : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            a2badf5b190b0ab8c : a2c9b8f77fb19b963(),
            aaa8080f103d8e1de : 0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(),
        }
    }

    public(friend) fun a761ed5468043598f() : u64 {
        1
    }

    public(friend) fun a86e56d31feeb19a6(arg0: &Ab258602200a3899b) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.ab831404733ad15a2
    }

    public(friend) fun a888b107d980228f4(arg0: &Ab258602200a3899b) : u64 {
        arg0.a07220bc61fe480d4
    }

    public(friend) fun a8e0f142d42cfb97e(arg0: u128, arg1: u64) : u128 {
        let v0 = (arg1 as u256) * 1000000000;
        let v1 = 1000000000 * 1000000000 * (arg0 as u256) * (arg0 as u256) / 340282366920938463463374607431768211456;
        let v2 = (arg0 as u256);
        loop {
            let v3 = v1 * 1000000000 / 1001000000;
            if (v3 < v0) {
                break
            };
            let v4 = v2 * 1000000000;
            v2 = v4 / 1000499875;
            v1 = v3;
        };
        loop {
            let v5 = v1 * 1000000000 / 1000050000;
            if (v5 < v0) {
                break
            };
            let v6 = v2 * 1000000000;
            v2 = v6 / 1000024999;
            v1 = v5;
        };
        (v2 as u128)
    }

    public(friend) fun a9706b71488d40615() : u64 {
        2
    }

    public(friend) fun aaa8080f103d8e1de(arg0: &mut Ad1f26f3c041612f2) : &mut 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position> {
        &mut arg0.aaa8080f103d8e1de
    }

    public(friend) fun aab87bac9248ea5a8() : u64 {
        0
    }

    public(friend) fun abd1f7455cc14de22(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u64, arg3: u64, arg4: u128) : Ab258602200a3899b {
        Ab258602200a3899b{
            ab831404733ad15a2 : arg0,
            a06096f5efca1025e : arg1,
            a2d2b06468676bab5 : arg2,
            a07220bc61fe480d4 : arg3,
            aafcb7cf7946a0bfd : arg4,
        }
    }

    public(friend) fun ac1087ea8a474f669(arg0: &mut Ad1f26f3c041612f2) : &mut Ab258602200a3899b {
        &mut arg0.ac1087ea8a474f669
    }

    public(friend) fun ac9df1aecf6db4076() : u64 {
        5
    }

    public(friend) fun acde36a6fa6c393c2(arg0: u128, arg1: u64) : u128 {
        let v0 = (arg1 as u256) * 1000000000;
        let v1 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v2 = (arg0 as u256);
        loop {
            let v3 = v1 * 1001000000 / 1000000000;
            if (v3 > v0) {
                break
            };
            let v4 = v2 * 1000000000;
            v2 = v4 / 1000499875;
            v1 = v3;
        };
        loop {
            let v5 = v1 * 1000050000 / 1000000000;
            if (v5 > v0) {
                break
            };
            let v6 = v2 * 1000000000;
            v2 = v6 / 1000024999;
            v1 = v5;
        };
        (v2 as u128)
    }

    public(friend) fun ad409a74018d3aacd(arg0: 0x1::string::String, arg1: &Ab258602200a3899b, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock) {
        let v0 = Adcace4a70f0f34a4{
            pool              : arg0,
            a2d2b06468676bab5 : arg1.a2d2b06468676bab5,
            a07220bc61fe480d4 : arg1.a07220bc61fe480d4,
            a5e2634f0e666a7a1 : arg2,
            ae273b39a0a3f5397 : arg3,
            a804f906337f5c9c4 : arg4,
            a963225d1fa28f7c6 : arg5,
            a64ae17ef03999f5b : arg6,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<Adcace4a70f0f34a4>(v0);
    }

    public fun adbacd5e16d57ada1(arg0: &mut Ad1f26f3c041612f2) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        arg0.a0adedbbdb2e7ecef = a2c9b8f77fb19b963();
        0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.a3c5cbfe902e7eac6)
    }

    public(friend) fun ae18556b7140949ca(arg0: &Ab258602200a3899b) : u64 {
        arg0.a2d2b06468676bab5
    }

    public(friend) fun aee479d24be81fbe9(arg0: u128, arg1: u64) : u128 {
        let v0 = (arg1 as u256) * 1000000000;
        let v1 = 340282366920938463463374607431768211456000000000000000000 / (arg0 as u256) * (arg0 as u256);
        let v2 = (arg0 as u256);
        loop {
            let v3 = v1 * 1000000000 / 1001000000;
            if (v3 < v0) {
                break
            };
            let v4 = v2 * 1000499875;
            v2 = v4 / 1000000000;
            v1 = v3;
        };
        loop {
            let v5 = v1 * 1000000000 / 1000050000;
            if (v5 < v0) {
                break
            };
            let v6 = v2 * 1000024999;
            v2 = v6 / 1000000000;
            v1 = v5;
        };
        (v2 as u128)
    }

    public(friend) fun af95ffd01d13caab1() : u64 {
        4
    }

    public(friend) fun afb1904d62fe08653(arg0: &Ab258602200a3899b) : u128 {
        arg0.aafcb7cf7946a0bfd
    }

    public(friend) fun afe80a6b6b615d930() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

