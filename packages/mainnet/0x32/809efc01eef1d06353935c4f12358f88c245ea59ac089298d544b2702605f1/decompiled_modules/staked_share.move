module 0x32809efc01eef1d06353935c4f12358f88c245ea59ac089298d544b2702605f1::staked_share {
    struct NumberPool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        available_shares: vector<StakedPoolShare<T0, T1, T2>>,
    }

    struct StakedPoolShare<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        start_num: u64,
        end_num: u64,
    }

    struct ShareSupply<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        active_supply: u64,
        total_supply: u64,
    }

    public fun active_supply<T0, T1, T2>(arg0: &ShareSupply<T0, T1, T2>) : u64 {
        arg0.active_supply
    }

    public(friend) fun amount<T0, T1, T2>(arg0: &StakedPoolShare<T0, T1, T2>) : u64 {
        arg0.end_num - arg0.start_num + 1
    }

    public fun end_num<T0, T1, T2>(arg0: &StakedPoolShare<T0, T1, T2>) : u64 {
        arg0.end_num
    }

    public fun merge<T0, T1, T2>(arg0: &mut StakedPoolShare<T0, T1, T2>, arg1: StakedPoolShare<T0, T1, T2>) {
        assert!(arg0.start_num == arg1.end_num + 1 || arg0.end_num + 1 == arg1.start_num, 1);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let StakedPoolShare {
            id        : v1,
            start_num : v2,
            end_num   : v3,
        } = arg1;
        if (arg0.start_num == v3 + 1) {
            arg0.start_num = v2;
        } else {
            arg0.end_num = v3;
        };
        0x2::dynamic_field::add<0x2::object::ID, u64>(&mut arg0.id, v0, 0x2::dynamic_field::remove<0x2::object::ID, u64>(&mut arg0.id, v0) + 0x2::dynamic_field::remove<0x2::object::ID, u64>(&mut arg1.id, 0x2::object::uid_to_inner(&arg1.id)));
        0x2::object::delete(v1);
    }

    public entry fun new_and_share_number_pool_and_share_supply<T0, T1, T2>(arg0: &0x32809efc01eef1d06353935c4f12358f88c245ea59ac089298d544b2702605f1::pool::GlobalConfig, arg1: &0x32809efc01eef1d06353935c4f12358f88c245ea59ac089298d544b2702605f1::pool::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x32809efc01eef1d06353935c4f12358f88c245ea59ac089298d544b2702605f1::pool::config_veriosn(arg0) == 1, 0);
        let v0 = NumberPool<T0, T1, T2>{
            id               : 0x2::object::new(arg2),
            available_shares : 0x1::vector::empty<StakedPoolShare<T0, T1, T2>>(),
        };
        0x2::transfer::share_object<NumberPool<T0, T1, T2>>(v0);
        let v1 = ShareSupply<T0, T1, T2>{
            id            : 0x2::object::new(arg2),
            active_supply : 0,
            total_supply  : 0,
        };
        0x2::transfer::share_object<ShareSupply<T0, T1, T2>>(v1);
    }

    public(friend) fun new_share<T0, T1, T2>(arg0: &0x32809efc01eef1d06353935c4f12358f88c245ea59ac089298d544b2702605f1::pool::GlobalConfig, arg1: &mut ShareSupply<T0, T1, T2>, arg2: &mut NumberPool<T0, T1, T2>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : vector<StakedPoolShare<T0, T1, T2>> {
        assert!(0x32809efc01eef1d06353935c4f12358f88c245ea59ac089298d544b2702605f1::pool::config_veriosn(arg0) == 1, 0);
        let v0 = arg3;
        let v1 = arg4;
        if (0x1::vector::length<StakedPoolShare<T0, T1, T2>>(&arg2.available_shares) == 0) {
            let v3 = StakedPoolShare<T0, T1, T2>{
                id        : 0x2::object::new(arg5),
                start_num : arg1.total_supply + 1,
                end_num   : arg1.total_supply + arg3,
            };
            arg1.total_supply = arg1.total_supply + arg3;
            arg1.active_supply = arg1.active_supply + arg3;
            0x2::dynamic_field::add<0x2::object::ID, u64>(&mut v3.id, 0x2::object::uid_to_inner(&v3.id), arg4);
            let v4 = 0x1::vector::empty<StakedPoolShare<T0, T1, T2>>();
            0x1::vector::push_back<StakedPoolShare<T0, T1, T2>>(&mut v4, v3);
            v4
        } else {
            let v5 = 0x1::vector::empty<StakedPoolShare<T0, T1, T2>>();
            while (0x1::vector::length<StakedPoolShare<T0, T1, T2>>(&arg2.available_shares) != 0) {
                let v6 = 0x1::vector::pop_back<StakedPoolShare<T0, T1, T2>>(&mut arg2.available_shares);
                let v7 = v6.end_num - v6.start_num + 1;
                if (v7 > v0) {
                    let v8 = &mut v6;
                    let v9 = split<T0, T1, T2>(v8, v0, arg5);
                    let v10 = 0x2::object::uid_to_inner(&v9.id);
                    0x2::dynamic_field::remove<0x2::object::ID, u64>(&mut v9.id, v10);
                    0x2::dynamic_field::add<0x2::object::ID, u64>(&mut v9.id, v10, v1);
                    0x1::vector::push_back<StakedPoolShare<T0, T1, T2>>(&mut v5, v9);
                    0x1::vector::push_back<StakedPoolShare<T0, T1, T2>>(&mut arg2.available_shares, v6);
                    arg1.active_supply = arg1.active_supply + v0;
                    v0 = 0;
                    break
                };
                if (v7 == v0) {
                    let v11 = 0x2::object::uid_to_inner(&v6.id);
                    0x2::dynamic_field::remove<0x2::object::ID, u64>(&mut v6.id, v11);
                    0x2::dynamic_field::add<0x2::object::ID, u64>(&mut v6.id, v11, v1);
                    0x1::vector::push_back<StakedPoolShare<T0, T1, T2>>(&mut v5, v6);
                    arg1.active_supply = arg1.active_supply + v0;
                    v0 = 0;
                    break
                };
                let v12 = (((((v7 as u128) * 1000000000 / (v0 as u128)) as u128) * (v1 as u128) / 1000000000) as u64);
                v1 = v1 - v12;
                let v13 = 0x2::object::uid_to_inner(&v6.id);
                0x2::dynamic_field::remove<0x2::object::ID, u64>(&mut v6.id, v13);
                0x2::dynamic_field::add<0x2::object::ID, u64>(&mut v6.id, v13, v12);
                0x1::vector::push_back<StakedPoolShare<T0, T1, T2>>(&mut v5, v6);
                v0 = v0 - v7;
                arg1.active_supply = arg1.active_supply + v7;
            };
            if (v0 != 0) {
                let v14 = StakedPoolShare<T0, T1, T2>{
                    id        : 0x2::object::new(arg5),
                    start_num : arg1.total_supply + 1,
                    end_num   : arg1.total_supply + v0,
                };
                0x2::dynamic_field::add<0x2::object::ID, u64>(&mut v14.id, 0x2::object::uid_to_inner(&v14.id), v1);
                0x1::vector::push_back<StakedPoolShare<T0, T1, T2>>(&mut v5, v14);
                arg1.total_supply = arg1.total_supply + v0;
                arg1.active_supply = arg1.active_supply + v0;
            };
            v5
        }
    }

    public fun split<T0, T1, T2>(arg0: &mut StakedPoolShare<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : StakedPoolShare<T0, T1, T2> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::dynamic_field::remove<0x2::object::ID, u64>(&mut arg0.id, v0);
        let v2 = arg1 * v1 * 1000000000 / amount<T0, T1, T2>(arg0) / 1000000000;
        let v3 = StakedPoolShare<T0, T1, T2>{
            id        : 0x2::object::new(arg2),
            start_num : arg0.start_num,
            end_num   : arg0.start_num + arg1 - 1,
        };
        0x2::dynamic_field::add<0x2::object::ID, u64>(&mut v3.id, 0x2::object::uid_to_inner(&v3.id), v2);
        arg0.start_num = arg0.start_num + arg1;
        0x2::dynamic_field::add<0x2::object::ID, u64>(&mut arg0.id, v0, v1 - v2);
        v3
    }

    public fun start_num<T0, T1, T2>(arg0: &StakedPoolShare<T0, T1, T2>) : u64 {
        arg0.start_num
    }

    public(friend) fun to_number_pool<T0, T1, T2>(arg0: &mut NumberPool<T0, T1, T2>, arg1: &mut ShareSupply<T0, T1, T2>, arg2: StakedPoolShare<T0, T1, T2>) {
        arg1.active_supply = arg1.active_supply - arg2.end_num - arg2.start_num + 1;
        0x1::vector::push_back<StakedPoolShare<T0, T1, T2>>(&mut arg0.available_shares, arg2);
    }

    public fun total_supply<T0, T1, T2>(arg0: &ShareSupply<T0, T1, T2>) : u64 {
        arg0.total_supply
    }

    public(friend) fun uid<T0, T1, T2>(arg0: &mut StakedPoolShare<T0, T1, T2>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

