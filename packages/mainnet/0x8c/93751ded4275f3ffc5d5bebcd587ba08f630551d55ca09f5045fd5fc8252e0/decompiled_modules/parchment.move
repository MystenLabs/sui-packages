module 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::parchment {
    struct PARCHMENT has drop {
        dummy_field: bool,
    }

    struct TreasuryWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARCHMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARCHMENT>(arg0, 9, b"PARCHMENT", b"PARCHMENT", b"Freely transferable. Not collateral.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARCHMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARCHMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun install_treasury<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: 0x2::coin::TreasuryCap<PARCHMENT>) {
        let v0 = TreasuryWitness{dummy_field: false};
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::install_committed_reward_cap<TreasuryWitness, T0, PARCHMENT>(v0, arg0, arg1, arg2, arg3);
    }

    public fun supply<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : u64 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::reward_supply<T0, PARCHMENT>(arg0)
    }

    // decompiled from Move bytecode v7
}

