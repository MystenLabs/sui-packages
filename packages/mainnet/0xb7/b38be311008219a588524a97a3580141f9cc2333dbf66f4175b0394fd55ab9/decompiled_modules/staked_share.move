module 0xb7b38be311008219a588524a97a3580141f9cc2333dbf66f4175b0394fd55ab9::staked_share {
    struct NumberPool<phantom T0, phantom T1: store + key> has key {
        id: 0x2::object::UID,
        available_shares: vector<StakedPoolShare<T0, T1>>,
    }

    struct StakedPoolShare<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_num: u64,
        end_num: u64,
    }

    struct ShareSupply<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        active_supply: u64,
        total_supply: u64,
    }

    public fun active_supply<T0, T1: store + key>(arg0: &ShareSupply<T0, T1>) : u64 {
        arg0.active_supply
    }

    public fun amount<T0, T1>(arg0: &StakedPoolShare<T0, T1>) : u64 {
        arg0.end_num - arg0.start_num + 1
    }

    public fun end_num<T0, T1: store + key>(arg0: &StakedPoolShare<T0, T1>) : u64 {
        arg0.end_num
    }

    public fun merge<T0, T1>(arg0: &mut StakedPoolShare<T0, T1>, arg1: StakedPoolShare<T0, T1>) {
        assert!(arg0.start_num == arg1.end_num + 1 || arg0.end_num + 1 == arg1.start_num, 0);
        let StakedPoolShare {
            id        : v0,
            start_num : v1,
            end_num   : v2,
        } = arg1;
        if (arg0.start_num == v2 + 1) {
            arg0.start_num = v1;
        } else {
            arg0.end_num = v2;
        };
        0x2::object::delete(v0);
    }

    public entry fun new_and_share_number_pool_and_share_supply<T0: store, T1: store + key>(arg0: &0xb7b38be311008219a588524a97a3580141f9cc2333dbf66f4175b0394fd55ab9::pool::AdminCap, arg1: &mut 0xb7b38be311008219a588524a97a3580141f9cc2333dbf66f4175b0394fd55ab9::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NumberPool<T0, T1>{
            id               : 0x2::object::new(arg2),
            available_shares : 0x1::vector::empty<StakedPoolShare<T0, T1>>(),
        };
        0xb7b38be311008219a588524a97a3580141f9cc2333dbf66f4175b0394fd55ab9::pool::fill_number_pool<T0, T1>(arg1, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<NumberPool<T0, T1>>(v0);
        let v1 = ShareSupply<T0, T1>{
            id            : 0x2::object::new(arg2),
            active_supply : 0,
            total_supply  : 0,
        };
        0x2::transfer::share_object<ShareSupply<T0, T1>>(v1);
    }

    public(friend) fun new_share<T0, T1: store + key>(arg0: &mut ShareSupply<T0, T1>, arg1: &mut NumberPool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<StakedPoolShare<T0, T1>> {
        let v0 = arg2;
        if (0x1::vector::length<StakedPoolShare<T0, T1>>(&arg1.available_shares) == 0) {
            arg0.total_supply = arg0.total_supply + arg2;
            arg0.active_supply = arg0.active_supply + arg2;
            let v2 = StakedPoolShare<T0, T1>{
                id        : 0x2::object::new(arg3),
                start_num : arg0.total_supply - arg2 + 1,
                end_num   : arg0.total_supply,
            };
            let v3 = 0x1::vector::empty<StakedPoolShare<T0, T1>>();
            0x1::vector::push_back<StakedPoolShare<T0, T1>>(&mut v3, v2);
            v3
        } else {
            let v4 = 0x1::vector::empty<StakedPoolShare<T0, T1>>();
            while (0x1::vector::length<StakedPoolShare<T0, T1>>(&arg1.available_shares) != 0) {
                let v5 = 0x1::vector::pop_back<StakedPoolShare<T0, T1>>(&mut arg1.available_shares);
                let v6 = v5.end_num - v5.start_num + 1;
                if (v6 > v0) {
                    let v7 = &mut v5;
                    let v8 = split<T0, T1>(v7, v0, arg3);
                    0x1::vector::push_back<StakedPoolShare<T0, T1>>(&mut v4, v8);
                    0x1::vector::push_back<StakedPoolShare<T0, T1>>(&mut arg1.available_shares, v5);
                    arg0.active_supply = arg0.active_supply + v0;
                    v0 = 0;
                    break
                };
                if (v6 == v0) {
                    0x1::vector::push_back<StakedPoolShare<T0, T1>>(&mut v4, v5);
                    arg0.active_supply = arg0.active_supply + v0;
                    v0 = 0;
                    break
                };
                0x1::vector::push_back<StakedPoolShare<T0, T1>>(&mut v4, v5);
                arg0.active_supply = arg0.active_supply + v6;
                v0 = v0 - v6;
            };
            if (v0 != 0) {
                arg0.total_supply = arg0.total_supply + v0;
                arg0.active_supply = arg0.active_supply + v0;
                let v9 = StakedPoolShare<T0, T1>{
                    id        : 0x2::object::new(arg3),
                    start_num : arg0.total_supply - v0 + 1,
                    end_num   : arg0.total_supply,
                };
                0x1::vector::push_back<StakedPoolShare<T0, T1>>(&mut v4, v9);
            };
            v4
        }
    }

    public fun split<T0, T1>(arg0: &mut StakedPoolShare<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : StakedPoolShare<T0, T1> {
        let v0 = StakedPoolShare<T0, T1>{
            id        : 0x2::object::new(arg2),
            start_num : arg0.start_num + arg1,
            end_num   : arg0.end_num,
        };
        arg0.end_num = arg0.end_num - arg1;
        v0
    }

    public fun start_num<T0, T1: store + key>(arg0: &StakedPoolShare<T0, T1>) : u64 {
        arg0.start_num
    }

    public(friend) fun to_number_pool<T0, T1: store + key>(arg0: &mut NumberPool<T0, T1>, arg1: &mut ShareSupply<T0, T1>, arg2: StakedPoolShare<T0, T1>) {
        arg1.active_supply = arg1.active_supply - arg2.end_num - arg2.start_num + 1;
        0x1::vector::push_back<StakedPoolShare<T0, T1>>(&mut arg0.available_shares, arg2);
    }

    public fun total_supply<T0, T1: store + key>(arg0: &ShareSupply<T0, T1>) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

