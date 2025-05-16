module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool {
    struct PoolCreatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolProtocolFeeCollectorCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_addr: address,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        config_addr: address,
        state_addr: address,
        fee_manager_addr: address,
    }

    struct BalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Balances<phantom T0, phantom T1> has store {
        base_reserve: 0x2::balance::Balance<T0>,
        quote_reserve: 0x2::balance::Balance<T1>,
        base_fee: 0x2::balance::Balance<T0>,
        quote_fee: 0x2::balance::Balance<T1>,
        base_protocol_fee: 0x2::balance::Balance<T0>,
        quote_protocol_fee: 0x2::balance::Balance<T1>,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_addr: address,
        config_addr: address,
        state_addr: address,
        fee_manager_addr: address,
        protocol_fee_collector_cap_addr: address,
        sender: address,
    }

    struct ProtocolFeeCollectedEvent has copy, drop {
        pool_addr: address,
        base_fee: u64,
        quote_fee: u64,
        sender: address,
    }

    public fun new<T0, T1>(arg0: &PoolCreatorCap, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg9: &0x1::option::Option<0xa8cc5ead60c188d252e1ae0db000ced612963772f541ba8d85fe93820ea24a1c::price_object::PriceObject>, arg10: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg11: &0x1::option::Option<0xda0b9a0ce68f4156f7b580f8a8fc8db2828ebcf0f04c223e5b009763d46edcc0::price_object::PriceObject>, arg12: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::new<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v1 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::new<T0, T1>(arg12);
        let v2 = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::new<T0, T1>(arg12);
        let v3 = Pool<T0, T1>{
            id               : 0x2::object::new(arg12),
            config_addr      : v0,
            state_addr       : v1,
            fee_manager_addr : v2,
        };
        let v4 = 0x2::object::id_address<Pool<T0, T1>>(&v3);
        let v5 = 0x2::object::new(arg12);
        let v6 = PoolProtocolFeeCollectorCap<T0, T1>{
            id        : v5,
            pool_addr : v4,
        };
        0x2::transfer::public_transfer<PoolProtocolFeeCollectorCap<T0, T1>>(v6, 0x2::tx_context::sender(arg12));
        let v7 = BalanceKey{dummy_field: false};
        let v8 = Balances<T0, T1>{
            base_reserve       : 0x2::balance::zero<T0>(),
            quote_reserve      : 0x2::balance::zero<T1>(),
            base_fee           : 0x2::balance::zero<T0>(),
            quote_fee          : 0x2::balance::zero<T1>(),
            base_protocol_fee  : 0x2::balance::zero<T0>(),
            quote_protocol_fee : 0x2::balance::zero<T1>(),
        };
        0x2::dynamic_field::add<BalanceKey, Balances<T0, T1>>(&mut v3.id, v7, v8);
        let v9 = PoolCreatedEvent{
            pool_addr                       : v4,
            config_addr                     : v0,
            state_addr                      : v1,
            fee_manager_addr                : v2,
            protocol_fee_collector_cap_addr : 0x2::object::uid_to_address(&v5),
            sender                          : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<PoolCreatedEvent>(v9);
        v3
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &PoolProtocolFeeCollectorCap<T0, T1>, arg1: &mut Pool<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.pool_addr == 0x2::object::id_address<Pool<T0, T1>>(arg1), 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::errors::EForbidden());
        let (v0, v1) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::get_acc_protocol_fees<T0, T1>(arg2);
        let (v2, v3) = 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::get_collected_protocol_fees<T0, T1>(arg2);
        let v4 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(v0, v2);
        let v5 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::sub(v1, v3);
        let v6 = withdraw_base_protocol_fee_coin<T0, T1>(arg1, arg2, v4, arg3);
        let v7 = withdraw_quote_protocol_fee_coin<T0, T1>(arg1, arg2, v5, arg3);
        let v8 = ProtocolFeeCollectedEvent{
            pool_addr : arg0.pool_addr,
            base_fee  : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v4),
            quote_fee : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v5),
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProtocolFeeCollectedEvent>(v8);
        (v6, v7)
    }

    public(friend) fun deposit_base_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg3: 0x2::coin::Coin<T0>) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0x2::balance::value<T0>(&v0));
        let v2 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2).base_reserve, v0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::increase_base_reserve<T0, T1>(arg2, arg1, v1);
        v1
    }

    public(friend) fun deposit_base_fee_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0x2::balance::value<T0>(&v0));
        let v2 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2).base_fee, v0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::add_base_acc_fee<T0, T1>(arg1, arg3, v1);
        v1
    }

    public(friend) fun deposit_base_protocol_fee_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg2: 0x2::coin::Coin<T0>) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0x2::balance::value<T0>(&v0));
        let v2 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2).base_protocol_fee, v0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::add_base_acc_protocol_fee<T0, T1>(arg1, v1);
        v1
    }

    public(friend) fun deposit_quote_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_config::PoolConfig<T0, T1>, arg2: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg3: 0x2::coin::Coin<T1>) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0x2::balance::value<T1>(&v0));
        let v2 = BalanceKey{dummy_field: false};
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2).quote_reserve, v0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::increase_quote_reserve<T0, T1>(arg2, arg1, v1);
        v1
    }

    public(friend) fun deposit_quote_fee_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0x2::coin::into_balance<T1>(arg2);
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0x2::balance::value<T1>(&v0));
        let v2 = BalanceKey{dummy_field: false};
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2).quote_fee, v0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::add_quote_acc_fee<T0, T1>(arg1, arg3, v1);
        v1
    }

    public(friend) fun deposit_quote_protocol_fee_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg2: 0x2::coin::Coin<T1>) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 0x2::coin::into_balance<T1>(arg2);
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0x2::balance::value<T1>(&v0));
        let v2 = BalanceKey{dummy_field: false};
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v2).quote_protocol_fee, v0);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::add_quote_acc_protocol_fee<T0, T1>(arg1, v1);
        v1
    }

    public fun get_config_addr<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.config_addr
    }

    public fun get_fee_manager_addr<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.fee_manager_addr
    }

    public fun get_state_addr<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.state_addr
    }

    public(friend) fun withdraw_base_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceKey{dummy_field: false};
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(arg2);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::decrease_base_reserve<T0, T1>(arg1, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).base_reserve, v1), arg3)
    }

    public(friend) fun withdraw_base_fee_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceKey{dummy_field: false};
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(arg2);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::collect_base_fee<T0, T1>(arg1, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).base_fee, v1), arg3)
    }

    public(friend) fun withdraw_base_protocol_fee_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceKey{dummy_field: false};
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(arg2);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::collect_base_protocol_fee<T0, T1>(arg1, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).base_protocol_fee, v1), arg3)
    }

    public(friend) fun withdraw_quote_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::PoolState<T0, T1>, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = BalanceKey{dummy_field: false};
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(arg2);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_state::decrease_quote_reserve<T0, T1>(arg1, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v1));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).quote_reserve, v1), arg3)
    }

    public(friend) fun withdraw_quote_fee_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = BalanceKey{dummy_field: false};
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(arg2);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::collect_quote_fee<T0, T1>(arg1, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v1));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).quote_fee, v1), arg3)
    }

    public(friend) fun withdraw_quote_protocol_fee_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::PoolFeeManager<T0, T1>, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = BalanceKey{dummy_field: false};
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(arg2);
        0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager::collect_quote_protocol_fee<T0, T1>(arg1, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v1));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0, T1>>(&mut arg0.id, v0).quote_protocol_fee, v1), arg3)
    }

    // decompiled from Move bytecode v6
}

