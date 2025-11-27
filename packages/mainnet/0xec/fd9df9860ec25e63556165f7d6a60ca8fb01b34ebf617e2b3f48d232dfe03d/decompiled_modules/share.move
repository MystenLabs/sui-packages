module 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share {
    struct Balance<phantom T0> has store {
        value: u64,
        market_id: 0x2::object::ID,
        outcome_index: u64,
    }

    struct Share<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: Balance<T0>,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Share<T0> {
        let v0 = Balance<T0>{
            value         : arg2,
            market_id     : arg0,
            outcome_index : arg1,
        };
        Share<T0>{
            id      : 0x2::object::new(arg3),
            balance : v0,
        }
    }

    public fun belongs_to_market<T0>(arg0: &Share<T0>, arg1: 0x2::object::ID) : bool {
        arg0.balance.market_id == arg1
    }

    public(friend) fun destroy<T0>(arg0: Share<T0>) : (0x2::object::ID, u64, u64) {
        let Share {
            id      : v0,
            balance : v1,
        } = arg0;
        let Balance {
            value         : v2,
            market_id     : v3,
            outcome_index : v4,
        } = v1;
        0x2::object::delete(v0);
        (v3, v4, v2)
    }

    public fun destroy_zero<T0>(arg0: Share<T0>) {
        let Share {
            id      : v0,
            balance : v1,
        } = arg0;
        let Balance {
            value         : v2,
            market_id     : _,
            outcome_index : _,
        } = v1;
        assert!(v2 == 0, 2);
        0x2::object::delete(v0);
    }

    public fun from_balance<T0>(arg0: Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : Share<T0> {
        Share<T0>{
            id      : 0x2::object::new(arg1),
            balance : arg0,
        }
    }

    public fun id<T0>(arg0: &Share<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun into_balance<T0>(arg0: Share<T0>) : Balance<T0> {
        let Share {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun is_zero<T0>(arg0: &Share<T0>) : bool {
        arg0.balance.value == 0
    }

    public fun join<T0>(arg0: &mut Share<T0>, arg1: Share<T0>) {
        let Share {
            id      : v0,
            balance : v1,
        } = arg1;
        let Balance {
            value         : v2,
            market_id     : v3,
            outcome_index : v4,
        } = v1;
        assert!(v3 == arg0.balance.market_id, 1);
        assert!(v4 == arg0.balance.outcome_index, 1);
        arg0.balance.value = arg0.balance.value + v2;
        0x2::object::delete(v0);
    }

    public fun join_vec<T0>(arg0: Share<T0>, arg1: vector<Share<T0>>) : Share<T0> {
        let v0 = arg0;
        0x1::vector::reverse<Share<T0>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Share<T0>>(&arg1)) {
            let v2 = v0;
            let v3 = &mut v2;
            join<T0>(v3, 0x1::vector::pop_back<Share<T0>>(&mut arg1));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Share<T0>>(arg1);
        v0
    }

    public fun keep_or_destroy_zero<T0>(arg0: Share<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (value<T0>(&arg0) == 0) {
            destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<Share<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun market_id<T0>(arg0: &Share<T0>) : 0x2::object::ID {
        arg0.balance.market_id
    }

    public fun outcome_index<T0>(arg0: &Share<T0>) : u64 {
        arg0.balance.outcome_index
    }

    public fun split<T0>(arg0: &mut Share<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Share<T0> {
        assert!(arg0.balance.value >= arg1, 0);
        arg0.balance.value = arg0.balance.value - arg1;
        let v0 = Balance<T0>{
            value         : arg1,
            market_id     : arg0.balance.market_id,
            outcome_index : arg0.balance.outcome_index,
        };
        Share<T0>{
            id      : 0x2::object::new(arg2),
            balance : v0,
        }
    }

    public fun value<T0>(arg0: &Share<T0>) : u64 {
        arg0.balance.value
    }

    // decompiled from Move bytecode v6
}

