module 0x23e6011211eff3e94b42d72cca6a0670c8678fa71aa34c83b78232b18f1bca89::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        operator: address,
        held: 0x2::balance::Balance<T0>,
    }

    struct Meter has drop, store {
        payee: address,
        rate: u64,
        max: u64,
        start_ms: u64,
        next_slot: u64,
    }

    fun advance<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (address, u64) {
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 1);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, Meter>(&mut arg0.id, arg1);
        assert!(arg2 == v0.next_slot, 5);
        assert!((arg2 + 1) * v0.rate <= v0.max, 3);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.start_ms + arg2 * 10000, 4);
        v0.next_slot = arg2 + 1;
        (v0.payee, v0.rate)
    }

    public fun close_meter<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.operator || 0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::dynamic_field::remove<u64, Meter>(&mut arg0.id, arg1);
    }

    public fun create<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id       : 0x2::object::new(arg1),
            owner    : 0x2::tx_context::sender(arg1),
            operator : arg0,
            held     : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.held, arg1);
    }

    public fun open_meter<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.operator, 1);
        let v0 = Meter{
            payee     : arg2,
            rate      : arg3,
            max       : arg4,
            start_ms  : 0x2::clock::timestamp_ms(arg5),
            next_slot : 0,
        };
        0x2::dynamic_field::add<u64, Meter>(&mut arg0.id, arg1, v0);
    }

    public fun owner_take<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        let v0 = arg0.owner;
        if (arg1 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0.held, arg1), v0);
        };
        if (arg2 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2)), v0);
        };
    }

    public fun tick<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = advance<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::balance::send_funds<T0>(0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, v1)), v0);
    }

    public fun tick_held<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = advance<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0.held, v1), v0);
    }

    // decompiled from Move bytecode v7
}

