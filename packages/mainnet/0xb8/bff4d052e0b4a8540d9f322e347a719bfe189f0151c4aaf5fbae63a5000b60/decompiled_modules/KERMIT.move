module 0xb8bff4d052e0b4a8540d9f322e347a719bfe189f0151c4aaf5fbae63a5000b60::KERMIT {
    struct KERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMIT>(arg0, 6, b"KERMIT", b"Kermit", b"just kermit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmYCUiSuDxunQSZLbi5FHMZhXeyU3fthZBrKVhb3m44GWV")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KERMIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

