module 0x8103a38e3f78a5e6972591e8acca03f5afaa4399ccd40c485e60413bb288d1a9::xs {
    struct XS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XS>(arg0, 9, b"XS", b"Xsan", b"Xsan about San", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1782adc1-a8ab-4043-bdc9-91a42f7a86e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XS>>(v1);
    }

    // decompiled from Move bytecode v6
}

