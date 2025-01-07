module 0x802e7ba3af2894b901a3ee376d0ec794ed6bed388052b85e048b4b13298a461::snl {
    struct SNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNL>(arg0, 6, b"SNL", b"snail", b"slow but strong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733060565208.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

