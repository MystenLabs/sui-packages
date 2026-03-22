module 0xa055c0a0949604a2a1452066ce1a837685ddbb119202973760b0984b93bd3bbc::zhar {
    struct ZHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHAR>(arg0, 6, b"Zhar", b"Zhartruse", b"The Zhartruse Project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1774144720975.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

