module 0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::allowance {
    struct Allowance<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        total_spent: u64,
        created_at: u64,
    }

    public fun balance<T0>(arg0: &Allowance<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun admin_deposit<T0>(arg0: &mut Allowance<T0>, arg1: &0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::AdminCap, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_deposited = arg0.total_deposited + v0;
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_allowance_deposited(arg0.owner, v0, 0x2::balance::value<T0>(&arg0.balance));
    }

    public fun create<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Allowance<T0>{
            id              : 0x2::object::new(arg1),
            owner           : 0x2::tx_context::sender(arg1),
            balance         : 0x2::balance::zero<T0>(),
            total_deposited : 0,
            total_spent     : 0,
            created_at      : 0x2::clock::timestamp_ms(arg0),
        };
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_allowance_created(0x2::tx_context::sender(arg1), 0x2::object::id<Allowance<T0>>(&v0));
        0x2::transfer::share_object<Allowance<T0>>(v0);
    }

    public fun deduct<T0>(arg0: &mut Allowance<T0>, arg1: &0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::Config, arg2: &0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::AdminCap, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::assert_version(arg1);
        assert!(!0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core::is_paused(arg1), 1);
        assert!(arg3 > 0, 2);
        assert!(arg4 <= 4, 13);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg3, 12);
        arg0.total_spent = arg0.total_spent + arg3;
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_allowance_deducted(arg0.owner, arg3, arg4, 0x2::balance::value<T0>(&arg0.balance));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg3), arg5), 0x2::tx_context::sender(arg5));
    }

    public fun deposit<T0>(arg0: &mut Allowance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 11);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposited = arg0.total_deposited + v0;
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_allowance_deposited(arg0.owner, v0, 0x2::balance::value<T0>(&arg0.balance));
    }

    public fun owner<T0>(arg0: &Allowance<T0>) : address {
        arg0.owner
    }

    public fun total_deposited<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.total_deposited
    }

    public fun total_spent<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.total_spent
    }

    public fun withdraw<T0>(arg0: &mut Allowance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 11);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > 0) {
            0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_allowance_withdrawn(arg0.owner, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun withdraw_amount<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 11);
        assert!(arg1 > 0, 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 12);
        0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events::emit_allowance_withdrawn(arg0.owner, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

