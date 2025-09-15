module 0x22f82727fd430213ebdab72eb6e7d35f13802e834fa9941307dbe324a51089b0::example {
    struct Sword has store, key {
        id: 0x2::object::UID,
        strength: u64,
    }

    public fun buy_sword_with_arbitrary_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : Sword {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
        create_sword(0x2::coin::value<T0>(&arg0), arg1)
    }

    public fun buy_sword_with_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : Sword {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        create_sword(0x2::coin::value<0x2::sui::SUI>(&arg0), arg1)
    }

    public fun buy_sword_with_usdc(arg0: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0x2::tx_context::TxContext) : Sword {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg0, @0x0);
        create_sword(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0), arg1)
    }

    fun create_sword(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Sword {
        Sword{
            id       : 0x2::object::new(arg1),
            strength : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

