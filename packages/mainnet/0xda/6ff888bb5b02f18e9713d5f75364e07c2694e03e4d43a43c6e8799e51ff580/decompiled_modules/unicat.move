module 0xda6ff888bb5b02f18e9713d5f75364e07c2694e03e4d43a43c6e8799e51ff580::unicat {
    struct UNICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICAT>(arg0, 6, b"UNICAT", b"SUI's Cat", b"The first phenomenal cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/a_ae_a_c_20240925043422_6338cd92ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

