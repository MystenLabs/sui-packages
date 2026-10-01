module 0xc2e772ce3d3dea1b7d4e893936c38622f12aee1a66022b42be846f606ef76d80::cscsc {
    struct CSCSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSCSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSCSC>(arg0, 9, b"cscsc", b"cscs", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CSCSC>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSCSC>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

