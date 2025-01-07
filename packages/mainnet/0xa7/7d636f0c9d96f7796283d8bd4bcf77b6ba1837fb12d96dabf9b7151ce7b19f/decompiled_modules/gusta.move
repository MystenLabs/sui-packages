module 0xa77d636f0c9d96f7796283d8bd4bcf77b6ba1837fb12d96dabf9b7151ce7b19f::gusta {
    struct GUSTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSTA>(arg0, 6, b"GUSTA", b"sui gusta", b"mi gusta.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_gusta_99bda060a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUSTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

