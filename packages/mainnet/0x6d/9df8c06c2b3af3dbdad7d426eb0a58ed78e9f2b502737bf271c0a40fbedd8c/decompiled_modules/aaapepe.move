module 0x6d9df8c06c2b3af3dbdad7d426eb0a58ed78e9f2b502737bf271c0a40fbedd8c::aaapepe {
    struct AAAPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPEPE>(arg0, 6, b"AaaPepe", b"AAAPepe", b"AAAPEPE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_194204_0000_2556b5b38f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

