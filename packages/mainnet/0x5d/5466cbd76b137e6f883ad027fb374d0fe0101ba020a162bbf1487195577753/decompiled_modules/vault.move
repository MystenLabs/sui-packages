module 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        reserved: u64,
        p2p_escrowed: u64,
        reserve_floor: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun absorb_p2p_escrow<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 201);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.p2p_escrowed = arg0.p2p_escrowed + v0;
    }

    public(friend) fun absorb_pot<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun assert_floor_after<T0>(arg0: &Vault<T0>, arg1: u64) {
        assert!(available<T0>(arg0) - arg1 >= arg0.reserve_floor, 204);
    }

    public fun available<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = arg0.reserved + arg0.p2p_escrowed;
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun balance_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun create_vault<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id            : 0x2::object::new(arg1),
            balance       : 0x2::balance::zero<T0>(),
            reserved      : 0,
            p2p_escrowed  : 0,
            reserve_floor : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 201);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::events::emit_admin(0x2::object::id<Vault<T0>>(arg0), b"deposit", v0, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), arg0.reserved, arg0.reserved, 0x2::tx_context::epoch_timestamp_ms(arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun p2p_escrowed<T0>(arg0: &Vault<T0>) : u64 {
        arg0.p2p_escrowed
    }

    public entry fun payout<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 201);
        assert!(arg0.reserved >= arg2, 203);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 200);
        arg0.reserved = arg0.reserved - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg4), arg3);
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::events::emit_admin(0x2::object::id<Vault<T0>>(arg0), b"payout", arg2, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), arg0.reserved, arg0.reserved, 0x2::tx_context::epoch_timestamp_ms(arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun release<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 201);
        assert!(arg0.reserved >= arg2, 203);
        arg0.reserved = arg0.reserved - arg2;
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::events::emit_admin(0x2::object::id<Vault<T0>>(arg0), b"release", arg2, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), arg0.reserved, arg0.reserved, 0x2::tx_context::epoch_timestamp_ms(arg3), 0x2::tx_context::sender(arg3));
    }

    public(friend) fun release_for_game<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        assert!(arg1 > 0, 201);
        assert!(arg0.reserved >= arg1, 203);
        arg0.reserved = arg0.reserved - arg1;
    }

    public(friend) fun release_p2p_escrow<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 201);
        assert!(arg0.p2p_escrowed >= arg1, 203);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 200);
        arg0.p2p_escrowed = arg0.p2p_escrowed - arg1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    public entry fun reserve<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 201);
        assert!(available<T0>(arg0) >= arg2, 200);
        assert_floor_after<T0>(arg0, arg2);
        arg0.reserved = arg0.reserved + arg2;
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::events::emit_admin(0x2::object::id<Vault<T0>>(arg0), b"reserve", arg2, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), arg0.reserved, arg0.reserved, 0x2::tx_context::epoch_timestamp_ms(arg3), 0x2::tx_context::sender(arg3));
    }

    public fun reserve_floor<T0>(arg0: &Vault<T0>) : u64 {
        arg0.reserve_floor
    }

    public(friend) fun reserve_for_game<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        assert!(arg1 > 0, 201);
        assert!(available<T0>(arg0) >= arg1, 200);
        assert_floor_after<T0>(arg0, arg1);
        arg0.reserved = arg0.reserved + arg1;
    }

    public fun reserved<T0>(arg0: &Vault<T0>) : u64 {
        arg0.reserved
    }

    public entry fun set_reserve_floor<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg0.reserve_floor = arg2;
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::events::emit_admin(0x2::object::id<Vault<T0>>(arg0), b"set_reserve_floor", arg2, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), arg0.reserved, arg0.reserved, 0x2::tx_context::epoch_timestamp_ms(arg3), 0x2::tx_context::sender(arg3));
    }

    public(friend) fun take_for_lp_redeem<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 201);
        assert!(available<T0>(arg0) >= arg1, 200);
        assert_floor_after<T0>(arg0, arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    public(friend) fun take_for_payout<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 201);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 200);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    public entry fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 201);
        assert!(available<T0>(arg0) >= arg2, 200);
        assert_floor_after<T0>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg4), arg3);
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::events::emit_admin(0x2::object::id<Vault<T0>>(arg0), b"withdraw", arg2, 0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.balance), arg0.reserved, arg0.reserved, 0x2::tx_context::epoch_timestamp_ms(arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

