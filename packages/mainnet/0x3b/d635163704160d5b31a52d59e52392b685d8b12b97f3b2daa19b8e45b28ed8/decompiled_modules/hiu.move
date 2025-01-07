module 0x3bd635163704160d5b31a52d59e52392b685d8b12b97f3b2daa19b8e45b28ed8::hiu {
    struct HIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIU>(arg0, 9, b"HIU", b"Hi", b"Yt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/409bcdf2-c2d9-40e5-8e98-5b285389fa96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

