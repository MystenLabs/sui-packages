module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state {
    struct PoolState<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        base_reserve: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_reserve: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        total_liquidity_point: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        last_trade_time_ms: 0x2::table::Table<address, u64>,
    }

    struct PoolStateCreatedEvent<phantom T0, phantom T1> has copy, drop {
        state_addr: address,
        sender: address,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = PoolState<T0, T1>{
            id                    : v0,
            base_reserve          : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_reserve         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            total_liquidity_point : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            last_trade_time_ms    : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<PoolState<T0, T1>>(v2);
        let v3 = PoolStateCreatedEvent<T0, T1>{
            state_addr : v1,
            sender     : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<PoolStateCreatedEvent<T0, T1>>(v3);
        v1
    }

    public(friend) fun burn_liquidity_points<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.total_liquidity_point = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(arg0.total_liquidity_point, arg1);
    }

    public(friend) fun decrease_base_reserve<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.base_reserve = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(arg0.base_reserve, arg1);
    }

    public(friend) fun decrease_quote_reserve<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.quote_reserve = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(arg0.quote_reserve, arg1);
    }

    public fun get_last_trade_time_ms<T0, T1>(arg0: &PoolState<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.last_trade_time_ms, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.last_trade_time_ms, arg1)
    }

    public fun get_reserves<T0, T1>(arg0: &PoolState<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_reserve, arg0.quote_reserve)
    }

    public fun get_total_liquidity_point<T0, T1>(arg0: &PoolState<T0, T1>) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        arg0.total_liquidity_point
    }

    public(friend) fun get_tvl<T0, T1>(arg0: &PoolState<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v0, arg1), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v1, arg2))
    }

    public(friend) fun increase_base_reserve<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        let (v0, _) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_reserves<T0, T1>(arg1);
        let v2 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.base_reserve, arg2);
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::le(v2, v0), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EBaseMaxReserveExceeded());
        arg0.base_reserve = v2;
    }

    public(friend) fun increase_quote_reserve<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        let (_, v1) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_reserves<T0, T1>(arg1);
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::le(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.quote_reserve, arg2), v1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EQuoteMaxReserveExceeded());
        arg0.quote_reserve = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.quote_reserve, arg2);
    }

    public(friend) fun mint_liquidity_points<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.total_liquidity_point = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.total_liquidity_point, arg1);
    }

    public(friend) fun update_last_trade_time_ms<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) {
        if (0x2::table::contains<address, u64>(&arg0.last_trade_time_ms, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.last_trade_time_ms, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.last_trade_time_ms, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

