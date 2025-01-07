module 0xd6d2c7a5d079ba47ed446ab7f8765bc78cbf0cc8d0468aa4ae9b981f63277769::bojo {
    struct BOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOJO>(arg0, 6, b"BOJO", b"Bojo", b"just a Bojo, OOOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955452199.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOJO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOJO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

