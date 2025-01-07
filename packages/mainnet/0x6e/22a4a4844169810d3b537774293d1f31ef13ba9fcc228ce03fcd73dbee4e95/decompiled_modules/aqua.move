module 0x6e22a4a4844169810d3b537774293d1f31ef13ba9fcc228ce03fcd73dbee4e95::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"AquaEvan", x"417175614576616e202d20496e737069726564206279200a404576616e576562330a2c20546865204c6567656e64617279205365612057617272696f7220616e6420526967687466756c204b696e67206f662054686520537569204b696e67646f6d20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002247675.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

