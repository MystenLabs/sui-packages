module 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fee_collector_registry {
    struct FeeCollectorRegistry has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : FeeCollectorRegistry {
        FeeCollectorRegistry{id: 0x2::object::new(arg0)}
    }

    public fun assert_registered(arg0: &FeeCollectorRegistry, arg1: 0x2::object::ID) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 0);
    }

    public fun borrow_fee_collector<T0>(arg0: &FeeCollectorRegistry, arg1: 0x2::object::ID) : &0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fee_collector::FeeCollector<T0> {
        assert_registered(arg0, arg1);
        0x2::dynamic_field::borrow<0x2::object::ID, 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fee_collector::FeeCollector<T0>>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut_fee_collector<T0>(arg0: &mut FeeCollectorRegistry, arg1: 0x2::object::ID) : &mut 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fee_collector::FeeCollector<T0> {
        assert_registered(arg0, arg1);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fee_collector::FeeCollector<T0>>(&mut arg0.id, arg1)
    }

    public(friend) fun register<T0>(arg0: &mut FeeCollectorRegistry, arg1: 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fee_collector::FeeCollector<T0>) {
        0x2::dynamic_field::add<0x2::object::ID, 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fee_collector::FeeCollector<T0>>(&mut arg0.id, 0x2::object::id<0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fee_collector::FeeCollector<T0>>(&arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

