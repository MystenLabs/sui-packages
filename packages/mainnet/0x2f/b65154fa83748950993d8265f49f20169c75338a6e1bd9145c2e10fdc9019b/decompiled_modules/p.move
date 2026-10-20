module 0x2fb65154fa83748950993d8265f49f20169c75338a6e1bd9145c2e10fdc9019b::p {
    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::PriceConfig, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg4);
        let (v0, v1) = 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::buy<T0>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), 0, 0x1::option::none<address>(), arg1, arg2, arg4);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        0x2::coin::into_balance<T0>(v0)
    }

    public fun sy<T0>(arg0: &mut 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg1: &0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::PriceConfig, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg4);
        let (v0, v1) = 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::buy<T0>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), 0, 0x1::option::none<address>(), arg1, arg2, arg4);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        0x2::coin::into_balance<T0>(v0)
    }

    public fun xs<T0>(arg0: &mut 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg2);
        0x2::coin::into_balance<0x2::sui::SUI>(0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sell<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), 0, 0x1::option::none<address>(), arg2))
    }

    public fun ys<T0>(arg0: &mut 0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::Curve<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg2);
        0x2::coin::into_balance<0x2::sui::SUI>(0x7b4163d17ce18b386ee50929ba48fa0a2ecb60304df4b07e26835aa18617cda2::bonding_curve::sell<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), 0, 0x1::option::none<address>(), arg2))
    }

    // decompiled from Move bytecode v7
}

