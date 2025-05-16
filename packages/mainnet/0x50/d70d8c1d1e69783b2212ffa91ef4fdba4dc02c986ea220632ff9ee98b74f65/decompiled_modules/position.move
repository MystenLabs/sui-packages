module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::position {
    struct PositionOwnerCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position_addr: address,
    }

    struct Position<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_addr: address,
        liquidity_point: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_acc_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_acc_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_collected_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_collected_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_fee_debt: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_fee_debt: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        last_increase_time_ms: u64,
        last_update_time_ms: u64,
    }

    struct PositionCreatedEvent<phantom T0, phantom T1> has copy, drop {
        position_addr: address,
        owner_cap_addr: address,
        pool_addr: address,
        owner: address,
        sender: address,
    }

    struct LiquidityIncreasedEvent<phantom T0, phantom T1> has copy, drop {
        position_addr: address,
        pool_addr: address,
        base_amount: u64,
        quote_amount: u64,
        liquidity_point: u64,
        sender: address,
    }

    struct LiquidityDecreasedEvent<phantom T0, phantom T1> has copy, drop {
        position_addr: address,
        pool_addr: address,
        base_amount: u64,
        quote_amount: u64,
        liquidity_point: u64,
        sender: address,
    }

    struct FeeCollectedEvent<phantom T0, phantom T1> has copy, drop {
        position_addr: address,
        pool_addr: address,
        base_amount: u64,
        quote_amount: u64,
        recipient: address,
        sender: address,
    }

    public fun borrow<T0, T1>(arg0: &Position<T0, T1>) : &Position<T0, T1> {
        arg0
    }

    public fun new<T0, T1>(arg0: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Position<T0, T1> {
        let v0 = 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg0);
        let v1 = Position<T0, T1>{
            id                    : 0x2::object::new(arg2),
            pool_addr             : v0,
            liquidity_point       : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            base_acc_fee          : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_acc_fee         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            base_collected_fee    : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_collected_fee   : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            base_fee_debt         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_fee_debt        : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            last_increase_time_ms : 0x2::clock::timestamp_ms(arg1),
            last_update_time_ms   : 0x2::clock::timestamp_ms(arg1),
        };
        let v2 = 0x2::object::id_address<Position<T0, T1>>(&v1);
        let v3 = 0x2::object::new(arg2);
        let v4 = PositionOwnerCap<T0, T1>{
            id            : v3,
            position_addr : v2,
        };
        0x2::transfer::public_transfer<PositionOwnerCap<T0, T1>>(v4, 0x2::tx_context::sender(arg2));
        let v5 = PositionCreatedEvent<T0, T1>{
            position_addr  : v2,
            owner_cap_addr : 0x2::object::uid_to_address(&v3),
            pool_addr      : v0,
            owner          : 0x2::tx_context::sender(arg2),
            sender         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PositionCreatedEvent<T0, T1>>(v5);
        v1
    }

    public fun collect_fees<T0, T1>(arg0: &PositionOwnerCap<T0, T1>, arg1: &mut Position<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        let v0 = 0x2::object::id_address<Position<T0, T1>>(arg1);
        assert!(arg0.position_addr == v0, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        assert!(arg1.pool_addr == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg2), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPositionPoolMismatch());
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg2) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg3), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        let (v1, v2) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::get_acc_fees_per_point<T0, T1>(arg3);
        sync_acc_fees<T0, T1>(arg1, v1, v2);
        let (v3, v4) = get_claimable_fees<T0, T1>(arg1, arg2, arg3);
        arg1.base_collected_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg1.base_collected_fee, v3);
        arg1.quote_collected_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg1.quote_collected_fee, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::withdraw_base_fee_coin<T0, T1>(arg2, arg3, v3, arg6), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::withdraw_quote_fee_coin<T0, T1>(arg2, arg3, v4, arg6), arg4);
        sync_fee_debts<T0, T1>(arg1, v1, v2);
        arg1.last_update_time_ms = 0x2::clock::timestamp_ms(arg5);
        let v5 = FeeCollectedEvent<T0, T1>{
            position_addr : v0,
            pool_addr     : arg1.pool_addr,
            base_amount   : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v3),
            quote_amount  : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v4),
            recipient     : arg4,
            sender        : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<FeeCollectedEvent<T0, T1>>(v5);
        (v3, v4)
    }

    public fun decrease_liquidity<T0, T1>(arg0: &PositionOwnerCap<T0, T1>, arg1: &mut Position<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg3: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg4: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg5: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 <= arg7, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETxExpired());
        let v1 = 0x2::object::id_address<Position<T0, T1>>(arg1);
        assert!(arg0.position_addr == v1, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        assert!(arg1.pool_addr == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg2), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPositionPoolMismatch());
        let v2 = if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_config_addr<T0, T1>(arg2) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>>(arg3)) {
            if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_state_addr<T0, T1>(arg2) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>>(arg4)) {
                0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg2) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        assert!(v0 >= arg1.last_increase_time_ms + 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_min_deposit_time_ms<T0, T1>(arg3), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EWithdrawTooEarly());
        assert!(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::ge(arg1.liquidity_point, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg6)), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EInsufficientLiquidity());
        let (v3, v4) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::get_acc_fees_per_point<T0, T1>(arg5);
        sync_acc_fees<T0, T1>(arg1, v3, v4);
        let v5 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_total_liquidity_point<T0, T1>(arg4);
        let (v6, v7) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_reserves<T0, T1>(arg4);
        let v8 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg6), v5), v6);
        let v9 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg6), v5), v7);
        arg1.liquidity_point = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(arg1.liquidity_point, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg6));
        sync_fee_debts<T0, T1>(arg1, v3, v4);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::burn_liquidity_points<T0, T1>(arg4, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(arg6));
        arg1.last_update_time_ms = 0x2::clock::timestamp_ms(arg8);
        let v10 = LiquidityDecreasedEvent<T0, T1>{
            position_addr   : v1,
            pool_addr       : arg1.pool_addr,
            base_amount     : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v8),
            quote_amount    : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v9),
            liquidity_point : arg6,
            sender          : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<LiquidityDecreasedEvent<T0, T1>>(v10);
        (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::withdraw_base_coin<T0, T1>(arg2, arg4, v8, arg9), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::withdraw_quote_coin<T0, T1>(arg2, arg4, v9, arg9))
    }

    public fun get_acc_fees<T0, T1>(arg0: &Position<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_acc_fee, arg0.quote_acc_fee)
    }

    public fun get_claimable_fees<T0, T1>(arg0: &Position<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg2: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPositionPoolMismatch());
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg1) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg2), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        let (v0, v1) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::get_acc_fees_per_point<T0, T1>(arg2);
        let (v2, v3) = get_acc_fees<T0, T1>(arg0);
        let (v4, v5) = get_fee_debts<T0, T1>(arg0);
        (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(v2, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v0, arg0.liquidity_point), v4)), arg0.base_collected_fee), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(v3, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v1, arg0.liquidity_point), v5)), arg0.quote_collected_fee))
    }

    public fun get_collected_fees<T0, T1>(arg0: &Position<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_collected_fee, arg0.quote_collected_fee)
    }

    public fun get_fee_debts<T0, T1>(arg0: &Position<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_fee_debt, arg0.quote_fee_debt)
    }

    public fun get_last_increase_time_ms<T0, T1>(arg0: &Position<T0, T1>) : u64 {
        arg0.last_increase_time_ms
    }

    public fun get_last_update_time_ms<T0, T1>(arg0: &Position<T0, T1>) : u64 {
        arg0.last_update_time_ms
    }

    public fun get_liquidity_point<T0, T1>(arg0: &Position<T0, T1>) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        arg0.liquidity_point
    }

    public fun get_position_reserves<T0, T1>(arg0: &Position<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg2: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPositionPoolMismatch());
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_state_addr<T0, T1>(arg1) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>>(arg2), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        let v0 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_total_liquidity_point<T0, T1>(arg2);
        let (v1, v2) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_reserves<T0, T1>(arg2);
        (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(arg0.liquidity_point, v0), v1), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(arg0.liquidity_point, v0), v2))
    }

    public fun increase_base_liquidity<T0, T1>(arg0: &mut Position<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg2: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg4: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg5: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg6: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg7: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg8: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg9: 0x2::coin::Coin<T0>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 <= arg10, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETxExpired());
        assert!(arg0.pool_addr == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPositionPoolMismatch());
        let v1 = if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_config_addr<T0, T1>(arg1) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>>(arg2)) {
            if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_state_addr<T0, T1>(arg1) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>>(arg3)) {
                0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg1) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        assert!(!0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::is_paused<T0, T1>(arg2), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolPaused());
        let (v2, v3, v4, v5) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::utils::fetch_prices<T0, T1>(arg2, arg5, arg6, arg7, arg8, arg11);
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_price_diff_ratio(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v2, v3), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v4, v5)) <= 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_price_diff_ratio<T0, T1>(arg2), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EMaxPriceDiffRatioExceeded());
        let v6 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(v2, v4), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(2));
        let (v7, v8) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::get_acc_fees_per_point<T0, T1>(arg4);
        sync_acc_fees<T0, T1>(arg0, v7, v8);
        let v9 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::deposit_base_coin<T0, T1>(arg1, arg2, arg3, arg9);
        let v10 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v9, v6), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_tvl<T0, T1>(arg3, v6, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(v3, v5), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(2))), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_total_liquidity_point<T0, T1>(arg3)));
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::mint_liquidity_points<T0, T1>(arg3, v10);
        arg0.liquidity_point = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.liquidity_point, v10);
        sync_fee_debts<T0, T1>(arg0, v7, v8);
        arg0.last_increase_time_ms = v0;
        arg0.last_update_time_ms = v0;
        let v11 = LiquidityIncreasedEvent<T0, T1>{
            position_addr   : 0x2::object::id_address<Position<T0, T1>>(arg0),
            pool_addr       : arg0.pool_addr,
            base_amount     : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v9),
            quote_amount    : 0,
            liquidity_point : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v10),
            sender          : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<LiquidityIncreasedEvent<T0, T1>>(v11);
        v10
    }

    public fun increase_quote_liquidity<T0, T1>(arg0: &mut Position<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>, arg2: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg3: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg4: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg5: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg6: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg7: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg8: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 <= arg10, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::ETxExpired());
        assert!(arg0.pool_addr == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::Pool<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPositionPoolMismatch());
        let v1 = if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_config_addr<T0, T1>(arg1) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>>(arg2)) {
            if (0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_state_addr<T0, T1>(arg1) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>>(arg3)) {
                0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::get_fee_manager_addr<T0, T1>(arg1) == 0x2::object::id_address<0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>>(arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolInfoMismatch());
        assert!(!0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::is_paused<T0, T1>(arg2), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EPoolPaused());
        let (v2, v3, v4, v5) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::utils::fetch_prices<T0, T1>(arg2, arg5, arg6, arg7, arg8, arg11);
        assert!(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pricing::get_price_diff_ratio(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v3, v2), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v5, v4)) <= 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::get_max_price_diff_ratio<T0, T1>(arg2), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EMaxPriceDiffRatioExceeded());
        let v6 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(v3, v5), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(2));
        let (v7, v8) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::get_acc_fees_per_point<T0, T1>(arg4);
        sync_acc_fees<T0, T1>(arg0, v7, v8);
        let v9 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool::deposit_quote_coin<T0, T1>(arg1, arg2, arg3, arg9);
        let v10 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(v9, v6), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_tvl<T0, T1>(arg3, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(v2, v4), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(2)), v6), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::get_total_liquidity_point<T0, T1>(arg3)));
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::mint_liquidity_points<T0, T1>(arg3, v10);
        arg0.liquidity_point = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.liquidity_point, v10);
        sync_fee_debts<T0, T1>(arg0, v7, v8);
        arg0.last_increase_time_ms = v0;
        arg0.last_update_time_ms = v0;
        let v11 = LiquidityIncreasedEvent<T0, T1>{
            position_addr   : 0x2::object::id_address<Position<T0, T1>>(arg0),
            pool_addr       : arg0.pool_addr,
            base_amount     : 0,
            quote_amount    : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v9),
            liquidity_point : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v10),
            sender          : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<LiquidityIncreasedEvent<T0, T1>>(v11);
        v10
    }

    public(friend) fun sync_acc_fees<T0, T1>(arg0: &mut Position<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.base_acc_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.base_acc_fee, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(arg1, arg0.liquidity_point), arg0.base_fee_debt));
        arg0.quote_acc_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.quote_acc_fee, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(arg2, arg0.liquidity_point), arg0.quote_fee_debt));
    }

    public(friend) fun sync_fee_debts<T0, T1>(arg0: &mut Position<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.base_fee_debt = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(arg1, arg0.liquidity_point);
        arg0.quote_fee_debt = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(arg2, arg0.liquidity_point);
    }

    // decompiled from Move bytecode v6
}

