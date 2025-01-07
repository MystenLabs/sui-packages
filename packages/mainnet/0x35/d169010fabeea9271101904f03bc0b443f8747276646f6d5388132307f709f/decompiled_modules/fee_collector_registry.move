module 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fee_collector_registry {
    struct FeeCollectorRegistry has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : FeeCollectorRegistry {
        FeeCollectorRegistry{id: 0x2::object::new(arg0)}
    }

    public fun assert_registered(arg0: &FeeCollectorRegistry, arg1: 0x2::object::ID) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 0);
    }

    public fun borrow_fee_collector<T0>(arg0: &FeeCollectorRegistry, arg1: 0x2::object::ID) : &0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fee_collector::FeeCollector<T0> {
        assert_registered(arg0, arg1);
        0x2::dynamic_field::borrow<0x2::object::ID, 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fee_collector::FeeCollector<T0>>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut_fee_collector<T0>(arg0: &mut FeeCollectorRegistry, arg1: 0x2::object::ID) : &mut 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fee_collector::FeeCollector<T0> {
        assert_registered(arg0, arg1);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fee_collector::FeeCollector<T0>>(&mut arg0.id, arg1)
    }

    public(friend) fun register<T0>(arg0: &mut FeeCollectorRegistry, arg1: 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fee_collector::FeeCollector<T0>) {
        0x2::dynamic_field::add<0x2::object::ID, 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fee_collector::FeeCollector<T0>>(&mut arg0.id, 0x2::object::id<0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fee_collector::FeeCollector<T0>>(&arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

