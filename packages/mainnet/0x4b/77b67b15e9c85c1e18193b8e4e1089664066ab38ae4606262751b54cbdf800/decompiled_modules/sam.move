module 0x4b77b67b15e9c85c1e18193b8e4e1089664066ab38ae4606262751b54cbdf800::sam {
    struct SamDeposit<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        depositor: address,
        manager: address,
        deposit_time: u64,
        strategy: u64,
    }

    struct DepositCreated<phantom T0> has copy, drop, store {
        deposit_id: 0x2::object::ID,
        depositor: address,
        manager: address,
        amount: u64,
        deposit_time: u64,
        strategy: u64,
    }

    struct DepositWithdrawn<phantom T0> has copy, drop, store {
        deposit_id: 0x2::object::ID,
        withdrawer: address,
        amount: u64,
    }

    struct ManagerWithdrawn<phantom T0> has copy, drop, store {
        deposit_id: 0x2::object::ID,
        manager: address,
        amount: u64,
    }

    public fun Deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != v0, 5);
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::object::new(arg4);
        let v5 = SamDeposit<T0>{
            id           : v4,
            balance      : v1,
            depositor    : v0,
            manager      : arg1,
            deposit_time : v3,
            strategy     : arg2,
        };
        0x2::transfer::share_object<SamDeposit<T0>>(v5);
        let v6 = DepositCreated<T0>{
            deposit_id   : 0x2::object::uid_to_inner(&v4),
            depositor    : v0,
            manager      : arg1,
            amount       : v2,
            deposit_time : v3,
            strategy     : arg2,
        };
        0x2::event::emit<DepositCreated<T0>>(v6);
    }

    public fun DepositInfo<T0>(arg0: &SamDeposit<T0>, arg1: &0x2::clock::Clock) : (address, address, u64, u64, u64) {
        (arg0.depositor, arg0.manager, 0x2::balance::value<T0>(&arg0.balance), arg0.deposit_time, arg0.strategy)
    }

    public fun Withdraw<T0>(arg0: SamDeposit<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.depositor, 4);
        let SamDeposit {
            id           : v1,
            balance      : v2,
            depositor    : _,
            manager      : _,
            deposit_time : _,
            strategy     : _,
        } = arg0;
        let v7 = v2;
        let v8 = 0x2::balance::value<T0>(&v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v7, v8, arg2), v0);
        let v9 = DepositWithdrawn<T0>{
            deposit_id : 0x2::object::uid_to_inner(&arg0.id),
            withdrawer : v0,
            amount     : v8,
        };
        0x2::event::emit<DepositWithdrawn<T0>>(v9);
        0x2::balance::destroy_zero<T0>(v7);
        0x2::object::delete(v1);
    }

    public fun WithdrawByManager<T0>(arg0: SamDeposit<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.manager, 4);
        let SamDeposit {
            id           : v1,
            balance      : v2,
            depositor    : _,
            manager      : _,
            deposit_time : _,
            strategy     : _,
        } = arg0;
        let v7 = v2;
        let v8 = 0x2::balance::value<T0>(&v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v7, v8, arg2), v0);
        let v9 = ManagerWithdrawn<T0>{
            deposit_id : 0x2::object::uid_to_inner(&arg0.id),
            manager    : v0,
            amount     : v8,
        };
        0x2::event::emit<ManagerWithdrawn<T0>>(v9);
        0x2::balance::destroy_zero<T0>(v7);
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

