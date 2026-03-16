module 0xdde75371dabc4cb0f7e4eb65c350d65bfddeff765f7cace18066cacc1fec16a1::pool {
    struct PoolConfig has store, key {
        id: 0x2::object::UID,
    }

    struct LendingPool has key {
        id: 0x2::object::UID,
        l: u16,
    }

    struct Position<phantom T0> {
        a: u64,
        m: u64,
    }

    struct PoolDeposit has copy, drop {
        a: u64,
    }

    struct PoolWithdraw has copy, drop {
        a: u64,
    }

    public(friend) fun b5w<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        let Position {
            a : _,
            m : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 2);
        let v2 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public(friend) fun f4d<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        let Position {
            a : _,
            m : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 2);
        let v2 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public(friend) fun h6y<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        let Position {
            a : _,
            m : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 2);
        let v2 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolConfig{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolConfig>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LendingPool{
            id : 0x2::object::new(arg0),
            l  : 100,
        };
        0x2::transfer::share_object<LendingPool>(v1);
    }

    public(friend) fun j8v<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2);
        let v2 = Position<T0>{
            a : arg1,
            m : arg1 * (10000 - (arg0.l as u64)) / 10000,
        };
        (v1, v2)
    }

    public(friend) fun n1g<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        let Position {
            a : _,
            m : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 2);
        let v2 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public(friend) fun p3x<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        let Position {
            a : _,
            m : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 2);
        let v2 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public(friend) fun q7z<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2);
        let v2 = Position<T0>{
            a : arg1,
            m : arg1 * (10000 - (arg0.l as u64)) / 10000,
        };
        (v1, v2)
    }

    public(friend) fun r9m<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2);
        let v2 = Position<T0>{
            a : arg1,
            m : arg1 * (10000 - (arg0.l as u64)) / 10000,
        };
        (v1, v2)
    }

    public entry fun rebalance_pool<T0>(arg0: &mut LendingPool, arg1: &PoolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v1 = PoolWithdraw{a: arg2};
        0x2::event::emit<PoolWithdraw>(v1);
    }

    public entry fun set_utilization(arg0: &mut LendingPool, arg1: &PoolConfig, arg2: u16) {
        arg0.l = arg2;
    }

    public(friend) fun t5n<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2);
        let v2 = Position<T0>{
            a : arg1,
            m : arg1 * (10000 - (arg0.l as u64)) / 10000,
        };
        (v1, v2)
    }

    fun tk<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    public entry fun update_reserves<T0>(arg0: &mut LendingPool, arg1: &PoolConfig, arg2: 0x2::coin::Coin<T0>) {
        let v0 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg2));
        };
        let v1 = PoolDeposit{a: 0x2::coin::value<T0>(&arg2)};
        0x2::event::emit<PoolDeposit>(v1);
    }

    public(friend) fun w2k<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2);
        let v2 = Position<T0>{
            a : arg1,
            m : arg1 * (10000 - (arg0.l as u64)) / 10000,
        };
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

