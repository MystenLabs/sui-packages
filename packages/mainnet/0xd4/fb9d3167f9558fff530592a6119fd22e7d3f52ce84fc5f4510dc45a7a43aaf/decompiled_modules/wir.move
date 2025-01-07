module 0xd4fb9d3167f9558fff530592a6119fd22e7d3f52ce84fc5f4510dc45a7a43aaf::wir {
    struct WIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIR>(arg0, 6, b"WIR", b"SHA", b"Yo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/def12305a72fefc082956dfa6844fa32_e684ac593c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

