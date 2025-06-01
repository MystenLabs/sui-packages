module 0xe4bf66010834ed3476eeca68a805b0d8ee89dea992aa42b76bc729826ef948d3::wynn {
    struct WYNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYNN>(arg0, 6, b"Wynn", b"JamesWynn", x"2457594e4e2069732061206d656d652d706f776572656420746f6b656e20626f726e2066726f6d2074686520737069726974206f662063727970746f277320626f6c6465737420747261646572200ae28094204a616d65732057796e6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748774255105.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYNN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYNN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

