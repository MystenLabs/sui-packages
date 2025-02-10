module 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::strategy_registry {
    struct StrategyKey<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        dummy_field: bool,
    }

    struct StrategyRegistry has key {
        id: 0x2::object::UID,
        strategies: 0x2::bag::Bag,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyRegistry{
            id         : 0x2::object::new(arg0),
            strategies : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<StrategyRegistry>(v0);
    }

    public(friend) fun register_strategy<T0, T1, T2>(arg0: &mut StrategyRegistry, arg1: 0x2::object::ID) {
        let v0 = StrategyKey<T0, T1, T2>{dummy_field: false};
        assert!(!0x2::bag::contains<StrategyKey<T0, T1, T2>>(&arg0.strategies, v0), 0);
        0x2::bag::add<StrategyKey<T0, T1, T2>, 0x2::object::ID>(&mut arg0.strategies, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

