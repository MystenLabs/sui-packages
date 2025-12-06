module 0x4377ddfad1dc3db8b665ac73115c3100ae01e82167aeacd4f2e69e961b99340c::share {
    struct Balance has store {
        value: u64,
        market_id: 0x2::object::ID,
        outcome_index: u64,
    }

    struct Share has store, key {
        id: 0x2::object::UID,
        balance: Balance,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Share {
        let v0 = Balance{
            value         : arg2,
            market_id     : arg0,
            outcome_index : arg1,
        };
        Share{
            id      : 0x2::object::new(arg3),
            balance : v0,
        }
    }

    public fun belongs_to_market(arg0: &Share, arg1: 0x2::object::ID) : bool {
        arg0.balance.market_id == arg1
    }

    public(friend) fun destroy(arg0: Share) : (0x2::object::ID, u64, u64) {
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

    public fun destroy_zero(arg0: Share) {
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

    public fun from_balance(arg0: Balance, arg1: &mut 0x2::tx_context::TxContext) : Share {
        Share{
            id      : 0x2::object::new(arg1),
            balance : arg0,
        }
    }

    public fun id(arg0: &Share) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun into_balance(arg0: Share) : Balance {
        let Share {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun is_zero(arg0: &Share) : bool {
        arg0.balance.value == 0
    }

    public fun join(arg0: &mut Share, arg1: Share) {
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

    public fun join_vec(arg0: Share, arg1: vector<Share>) : Share {
        let v0 = arg0;
        0x1::vector::reverse<Share>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Share>(&arg1)) {
            let v2 = v0;
            let v3 = &mut v2;
            join(v3, 0x1::vector::pop_back<Share>(&mut arg1));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Share>(arg1);
        v0
    }

    public fun keep_or_destroy_zero(arg0: Share, arg1: &mut 0x2::tx_context::TxContext) {
        if (value(&arg0) == 0) {
            destroy_zero(arg0);
        } else {
            0x2::transfer::public_transfer<Share>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun market_id(arg0: &Share) : 0x2::object::ID {
        arg0.balance.market_id
    }

    public fun outcome_index(arg0: &Share) : u64 {
        arg0.balance.outcome_index
    }

    public fun split(arg0: &mut Share, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Share {
        assert!(arg0.balance.value >= arg1, 0);
        arg0.balance.value = arg0.balance.value - arg1;
        let v0 = Balance{
            value         : arg1,
            market_id     : arg0.balance.market_id,
            outcome_index : arg0.balance.outcome_index,
        };
        Share{
            id      : 0x2::object::new(arg2),
            balance : v0,
        }
    }

    public fun value(arg0: &Share) : u64 {
        arg0.balance.value
    }

    // decompiled from Move bytecode v6
}

