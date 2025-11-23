module 0xf6782b55546f5066b4e9df360c6d0979db41568cbf5af888d7142094ec356a5d::ad9e4d11aecc532fa {
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
    }

    struct Ad1f26f3c041612f2 has store {
        a2c4ad235d50c110f: Ab258602200a3899b,
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

    public(friend) fun a21b8c64204576499(arg0: &Ab258602200a3899b) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.a06096f5efca1025e
    }

    public(friend) fun a2c4ad235d50c110f(arg0: &mut Ad1f26f3c041612f2) : &mut Ab258602200a3899b {
        &mut arg0.a2c4ad235d50c110f
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

    public(friend) fun a75d4519aec44b4ef() : Ad1f26f3c041612f2 {
        Ad1f26f3c041612f2{
            a2c4ad235d50c110f : a2c9b8f77fb19b963(),
            a817c3e383e2f23d1 : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
        }
    }

    public(friend) fun a817c3e383e2f23d1(arg0: &mut Ad1f26f3c041612f2) : &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position> {
        &mut arg0.a817c3e383e2f23d1
    }

    public(friend) fun a86e56d31feeb19a6(arg0: &Ab258602200a3899b) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.ab831404733ad15a2
    }

    public(friend) fun a888b107d980228f4(arg0: &Ab258602200a3899b) : u64 {
        arg0.a07220bc61fe480d4
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

    public(friend) fun abd1f7455cc14de22(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u64, arg3: u64, arg4: u128) : Ab258602200a3899b {
        Ab258602200a3899b{
            ab831404733ad15a2 : arg0,
            a06096f5efca1025e : arg1,
            a2d2b06468676bab5 : arg2,
            a07220bc61fe480d4 : arg3,
            aafcb7cf7946a0bfd : arg4,
        }
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

    public(friend) fun ad409a74018d3aacd(arg0: 0x1::string::String, arg1: &Ab258602200a3899b, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::object::ID) {
        let v0 = Adcace4a70f0f34a4{
            pool              : arg0,
            a2d2b06468676bab5 : arg1.a2d2b06468676bab5,
            a07220bc61fe480d4 : arg1.a07220bc61fe480d4,
            a5e2634f0e666a7a1 : arg2,
            ae273b39a0a3f5397 : arg3,
            a804f906337f5c9c4 : arg4,
            a963225d1fa28f7c6 : arg5,
            a64ae17ef03999f5b : arg6,
        };
        0x2::event::emit<Adcace4a70f0f34a4>(v0);
    }

    public(friend) fun ae0a2f8b7674831a4() : u64 {
        0
    }

    public(friend) fun ae18556b7140949ca(arg0: &Ab258602200a3899b) : u64 {
        arg0.a2d2b06468676bab5
    }

    public fun ae442be240c3f0473(arg0: &mut Ad1f26f3c041612f2) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        arg0.a2c4ad235d50c110f = a2c9b8f77fb19b963();
        0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.a817c3e383e2f23d1)
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

    public(friend) fun afb1904d62fe08653(arg0: &Ab258602200a3899b) : u128 {
        arg0.aafcb7cf7946a0bfd
    }

    public(friend) fun afe80a6b6b615d930() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

