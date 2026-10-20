module 0xc7482c7178d3f32203aec0d46e2990361d7edb653aebfcafeb1b692dc9e1fde3::p {
    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::BondingCurve<T0>, arg1: &mut 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::Configurator, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        0x2::coin::into_balance<T0>(0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::buy<T0>(arg0, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg3), 0, arg3))
    }

    public fun xs<T0>(arg0: &mut 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::BondingCurve<T0>, arg1: &mut 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::Configurator, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg3);
        0x2::coin::into_balance<0x2::sui::SUI>(0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::sell<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg3), 0, arg3))
    }

    // decompiled from Move bytecode v7
}

