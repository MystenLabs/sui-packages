module 0x8cabc3ede4c6ce542b4fd868d5d399fe6c49d598324887ed662fd47ca9582b41::ph_sui {
    struct PH_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PH_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PH_SUI>(arg0, 9, b"phSUI", b"Phantom Staked SUI", b"Phantom staked SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,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")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PH_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PH_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

