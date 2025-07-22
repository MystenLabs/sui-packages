module 0xfa14a565c002fb49527de6dffc6db8b1b4cfec47e82c7dfd9e6e590eac66e1c6::locker {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        lock_fee: u64,
        admin: address,
    }

    struct LockContract<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        amount: u64,
        start_time: u64,
        end_time: u64,
        locker: address,
        recipient: address,
        closed: bool,
    }

    public entry fun create_lock<T0>(arg0: &Configuration, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg3 >= 10000, 1);
        assert!(arg4 > v0, 2);
        let v1 = arg3 * arg0.lock_fee / 10000;
        assert!(0x2::coin::value<T0>(&arg1) >= arg3 + v1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg6), arg0.admin);
        let v2 = LockContract<T0>{
            id         : 0x2::object::new(arg6),
            balance    : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg3, arg6)),
            amount     : arg3,
            start_time : v0,
            end_time   : arg4,
            locker     : 0x2::tx_context::sender(arg6),
            recipient  : arg2,
            closed     : false,
        };
        refund<T0>(arg1, arg6);
        0x2::transfer::share_object<LockContract<T0>>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Configuration{
            id       : 0x2::object::new(arg0),
            lock_fee : 0,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Configuration>(v1);
    }

    public fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public entry fun withdraw<T0>(arg0: &Configuration, arg1: &mut LockContract<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (v0 == arg0.admin) {
            true
        } else if (v0 == arg1.recipient) {
            true
        } else {
            v0 == arg1.locker
        };
        assert!(v1, 4);
        assert!(!arg1.closed, 5);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_time, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg3), arg1.recipient);
        arg1.closed = true;
    }

    // decompiled from Move bytecode v6
}

