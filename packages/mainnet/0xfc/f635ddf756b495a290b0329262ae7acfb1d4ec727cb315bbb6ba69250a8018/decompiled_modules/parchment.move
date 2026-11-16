module 0xdfff755d5fa3097da2a8e9da17c0787ea185c05798ad04d5983a26c7a778a32d::parchment {
    struct PARCHMENT has drop {
        dummy_field: bool,
    }

    struct TreasuryWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARCHMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARCHMENT>(arg0, 9, b"PARCHMENT", b"Parchment", b"The Parchment protocol token: minted on realized trader losses and achievements.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://parchment.trade/coin-icon/parchment.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARCHMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARCHMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun install_treasury<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: 0x2::coin::TreasuryCap<PARCHMENT>) {
        let v0 = TreasuryWitness{dummy_field: false};
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::install_committed_reward_cap<TreasuryWitness, T0, PARCHMENT>(v0, arg0, arg1, arg2, arg3);
    }

    public fun supply<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>) : u64 {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::reward_supply<T0, PARCHMENT>(arg0)
    }

    // decompiled from Move bytecode v7
}

