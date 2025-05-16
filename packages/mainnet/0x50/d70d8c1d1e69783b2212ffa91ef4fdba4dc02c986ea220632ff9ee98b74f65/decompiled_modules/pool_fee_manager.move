module 0x50d70d8c1d1e69783b2212ffa91ef4fdba4dc02c986ea220632ff9ee98b74f65::pool_fee_manager {
    struct PoolFeeManager<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        base_acc_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_acc_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_acc_protocol_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_acc_protocol_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_collected_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_collected_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_collected_protocol_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_collected_protocol_fee: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        base_acc_fee_per_point: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        quote_acc_fee_per_point: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
    }

    struct PoolFeeManagerCreatedEvent<phantom T0, phantom T1> has copy, drop {
        fee_manager_addr: address,
        sender: address,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = PoolFeeManager<T0, T1>{
            id                           : v0,
            base_acc_fee                 : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_acc_fee                : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            base_acc_protocol_fee        : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_acc_protocol_fee       : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            base_collected_fee           : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_collected_fee          : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            base_collected_protocol_fee  : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_collected_protocol_fee : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            base_acc_fee_per_point       : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
            quote_acc_fee_per_point      : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0),
        };
        0x2::transfer::share_object<PoolFeeManager<T0, T1>>(v2);
        let v3 = PoolFeeManagerCreatedEvent<T0, T1>{
            fee_manager_addr : v1,
            sender           : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<PoolFeeManagerCreatedEvent<T0, T1>>(v3);
        v1
    }

    public(friend) fun add_base_acc_fee<T0, T1>(arg0: &mut PoolFeeManager<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.base_acc_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.base_acc_fee, arg2);
        arg0.base_acc_fee_per_point = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.base_acc_fee_per_point, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(arg2, arg1));
    }

    public(friend) fun add_base_acc_protocol_fee<T0, T1>(arg0: &mut PoolFeeManager<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.base_acc_protocol_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.base_acc_protocol_fee, arg1);
    }

    public(friend) fun add_quote_acc_fee<T0, T1>(arg0: &mut PoolFeeManager<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg2: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.quote_acc_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.quote_acc_fee, arg2);
        arg0.quote_acc_fee_per_point = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.quote_acc_fee_per_point, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(arg2, arg1));
    }

    public(friend) fun add_quote_acc_protocol_fee<T0, T1>(arg0: &mut PoolFeeManager<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.quote_acc_protocol_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.quote_acc_protocol_fee, arg1);
    }

    public(friend) fun collect_base_fee<T0, T1>(arg0: &mut PoolFeeManager<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.base_collected_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.base_collected_fee, arg1);
    }

    public(friend) fun collect_base_protocol_fee<T0, T1>(arg0: &mut PoolFeeManager<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.base_collected_protocol_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.base_collected_protocol_fee, arg1);
    }

    public(friend) fun collect_quote_fee<T0, T1>(arg0: &mut PoolFeeManager<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.quote_collected_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.quote_collected_fee, arg1);
    }

    public(friend) fun collect_quote_protocol_fee<T0, T1>(arg0: &mut PoolFeeManager<T0, T1>, arg1: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        arg0.quote_collected_protocol_fee = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(arg0.quote_collected_protocol_fee, arg1);
    }

    public fun get_acc_fees<T0, T1>(arg0: &PoolFeeManager<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_acc_fee, arg0.quote_acc_fee)
    }

    public fun get_acc_fees_per_point<T0, T1>(arg0: &PoolFeeManager<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_acc_fee_per_point, arg0.quote_acc_fee_per_point)
    }

    public fun get_acc_protocol_fees<T0, T1>(arg0: &PoolFeeManager<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_acc_protocol_fee, arg0.quote_acc_protocol_fee)
    }

    public fun get_collected_fees<T0, T1>(arg0: &PoolFeeManager<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_collected_fee, arg0.quote_collected_fee)
    }

    public fun get_collected_protocol_fees<T0, T1>(arg0: &PoolFeeManager<T0, T1>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal) {
        (arg0.base_collected_protocol_fee, arg0.quote_collected_protocol_fee)
    }

    // decompiled from Move bytecode v6
}

