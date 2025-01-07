module 0x774b45ac4a661a7c3b48d25bfae607047493be2e6f6b04927857c87e848dc4c1::distributor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct State<phantom T0> has key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, u64>,
        total_distributed: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun balance<T0>(arg0: &State<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun withdraw_all<T0: drop>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg3), arg2);
    }

    public fun available<T0>(arg0: &State<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.whitelist, arg1)
    }

    public entry fun claim<T0: drop>(arg0: &mut State<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_distributed<T0>(arg0, v0), 1);
        let v1 = available<T0>(arg0, v0);
        assert!(v1 > 0, 2);
        assert!(balance<T0>(arg0) >= v1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg1), v0);
        set_claimed_for<T0>(arg0, v0);
    }

    public entry fun create_state<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = State<T0>{
            id                : 0x2::object::new(arg1),
            whitelist         : 0x2::table::new<address, u64>(arg1),
            total_distributed : 0,
            balance           : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<State<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun distribute<T0: drop>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg3, v0);
            if (0x2::table::contains<address, u64>(&arg1.whitelist, v1)) {
                let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg1.whitelist, v1);
                arg1.total_distributed = arg1.total_distributed - *v3;
                *v3 = v2;
            } else {
                0x2::table::add<address, u64>(&mut arg1.whitelist, v1, v2);
            };
            arg1.total_distributed = arg1.total_distributed + v2;
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_distributed<T0>(arg0: &State<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.whitelist, arg1)
    }

    fun set_claimed_for<T0>(arg0: &mut State<T0>, arg1: address) {
        *0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, arg1) = 0;
    }

    public entry fun withdraw<T0: drop>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

