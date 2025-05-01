module 0xf3673b726ccc64f607bfb4ad3c368812fd753c2e8b436848115eb042ea6aba97::mtn_sui {
    struct MTN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTN_SUI>(arg0, 9, b"mtnSUI", b"asema Staked SUI", b"porvoon kaupunki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/1e9cabde-7336-4d98-acc9-74261982bdce/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTN_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTN_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

