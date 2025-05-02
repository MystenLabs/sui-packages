module 0x1ef9719eb786be6643e6e86c3b975c9b690ed52d8438de0160ca0731e55d6074::telev_sui {
    struct TELEV_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELEV_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELEV_SUI>(arg0, 9, b"televSUI", b"Televie Staked SUI", b"Supportons ensemble la recherche contre le cancer ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/c5c72eb2-ffef-4024-b3e4-8ca8a64d7cb5/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELEV_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TELEV_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

