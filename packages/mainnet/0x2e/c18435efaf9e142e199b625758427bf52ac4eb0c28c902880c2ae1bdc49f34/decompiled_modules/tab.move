module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::tab {
    struct Pending has copy, drop, store {
        cumulative: u64,
        counter: u64,
        at_ms: u64,
        disputed: bool,
    }

    struct Tab<phantom T0> has key {
        id: 0x2::object::UID,
        payer: address,
        payee: address,
        payer_pubkey: vector<u8>,
        locked: 0x2::balance::Balance<T0>,
        paid: u64,
        counter: u64,
        pending: 0x1::option::Option<Pending>,
        window_ms: u64,
        expiry_ms: u64,
    }

    struct TabEvent has copy, drop {
        tab: 0x2::object::ID,
        kind: u8,
        cumulative: u64,
        counter: u64,
    }

    public fun close<T0>(arg0: &mut Tab<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.payer, 304);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms + arg0.window_ms, 309);
        assert!(0x1::option::is_none<Pending>(&arg0.pending), 310);
        arg0.counter = 18446744073709551615;
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.locked), arg2)
    }

    public fun dispute<T0>(arg0: &mut Tab<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.payer, 304);
        assert!(0x1::option::is_some<Pending>(&arg0.pending), 306);
        let v0 = 0x1::option::borrow_mut<Pending>(&mut arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg1) < v0.at_ms + arg0.window_ms, 308);
        v0.disputed = true;
        let v1 = TabEvent{
            tab        : 0x2::object::id<Tab<T0>>(arg0),
            kind       : 2,
            cumulative : v0.cumulative,
            counter    : v0.counter,
        };
        0x2::event::emit<TabEvent>(v1);
    }

    public fun finalize<T0>(arg0: &mut Tab<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<Pending>(&arg0.pending), 306);
        let v0 = *0x1::option::borrow<Pending>(&arg0.pending);
        assert!(!v0.disputed, 307);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.at_ms + arg0.window_ms, 305);
        pay<T0>(arg0, v0.cumulative, arg2);
    }

    public fun locked<T0>(arg0: &Tab<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public fun message(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun open<T0>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg1: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 312);
        assert!(arg5 >= 3600000 && arg6 > 0x2::clock::timestamp_ms(arg7) + arg5, 313);
        let v0 = Tab<T0>{
            id           : 0x2::object::new(arg8),
            payer        : 0x2::tx_context::sender(arg8),
            payee        : arg3,
            payer_pubkey : arg4,
            locked       : 0x2::coin::into_balance<T0>(arg2),
            paid         : 0,
            counter      : 0,
            pending      : 0x1::option::none<Pending>(),
            window_ms    : arg5,
            expiry_ms    : arg6,
        };
        let v1 = TabEvent{
            tab        : 0x2::object::id<Tab<T0>>(&v0),
            kind       : 0,
            cumulative : 0,
            counter    : 0,
        };
        0x2::event::emit<TabEvent>(v1);
        0x2::transfer::share_object<Tab<T0>>(v0);
    }

    public fun paid<T0>(arg0: &Tab<T0>) : u64 {
        arg0.paid
    }

    fun pay<T0>(arg0: &mut Tab<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paid = arg1;
        arg0.pending = 0x1::option::none<Pending>();
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.locked, arg1 - arg0.paid), arg2), arg0.payee);
        let v0 = TabEvent{
            tab        : 0x2::object::id<Tab<T0>>(arg0),
            kind       : 3,
            cumulative : arg1,
            counter    : arg0.counter,
        };
        0x2::event::emit<TabEvent>(v0);
    }

    public fun resolve<T0>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut Tab<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<Pending>(&arg1.pending), 306);
        let v0 = *0x1::option::borrow<Pending>(&arg1.pending);
        assert!(v0.disputed, 306);
        let v1 = if (arg2 > v0.cumulative) {
            v0.cumulative
        } else {
            arg2
        };
        if (v1 > arg1.paid) {
            pay<T0>(arg1, v1, arg3);
        } else {
            arg1.pending = 0x1::option::none<Pending>();
        };
    }

    public fun settle<T0>(arg0: &mut Tab<T0>, arg1: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg2: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg1, arg2);
        assert!(0x2::tx_context::sender(arg7) == arg0.payee, 303);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.expiry_ms, 311);
        assert!(arg4 > arg0.counter, 301);
        if (0x1::option::is_some<Pending>(&arg0.pending)) {
            assert!(!0x1::option::borrow<Pending>(&arg0.pending).disputed, 307);
        };
        assert!(arg3 >= arg0.paid && arg3 - arg0.paid <= 0x2::balance::value<T0>(&arg0.locked), 302);
        let v0 = message(0x2::object::id<Tab<T0>>(arg0), arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.payer_pubkey, &v0), 300);
        arg0.counter = arg4;
        let v1 = Pending{
            cumulative : arg3,
            counter    : arg4,
            at_ms      : 0x2::clock::timestamp_ms(arg6),
            disputed   : false,
        };
        arg0.pending = 0x1::option::some<Pending>(v1);
        let v2 = TabEvent{
            tab        : 0x2::object::id<Tab<T0>>(arg0),
            kind       : 1,
            cumulative : arg3,
            counter    : arg4,
        };
        0x2::event::emit<TabEvent>(v2);
    }

    public fun top_up<T0>(arg0: &mut Tab<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.payer, 304);
        0x2::balance::join<T0>(&mut arg0.locked, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v7
}

