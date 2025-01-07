module 0xb353592d74169a9e34feb9714aa7722b3df9db87582d4aba7782e50d00e3f144::binu {
    struct BINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINU>(arg0, 9, b"BINU", b"Black INU", x"4d656f772e204c6574e280997320676f206361747320f09f9088e2808de2ac9b20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a31fcbc-6bf5-433b-82fb-c5434f2f46d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

