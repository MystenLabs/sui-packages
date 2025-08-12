module 0x1fea5652ae6ba58120a3262cff764b5abefe39ce603cdd5c5ca19fc584b6847e::strat_sui {
    struct STRAT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAT_SUI>(arg0, 9, b"stratSUI", b"Strategies Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,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")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

