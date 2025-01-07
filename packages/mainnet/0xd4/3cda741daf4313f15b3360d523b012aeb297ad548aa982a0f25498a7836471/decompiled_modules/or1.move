module 0xd43cda741daf4313f15b3360d523b012aeb297ad548aa982a0f25498a7836471::or1 {
    struct OR1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OR1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OR1>(arg0, 9, b"OR1", b"OR1YO ", b"Reliable for fast transaction ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e31d1bb4-5491-40c6-8b6d-578ea2ca61ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OR1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OR1>>(v1);
    }

    // decompiled from Move bytecode v6
}

