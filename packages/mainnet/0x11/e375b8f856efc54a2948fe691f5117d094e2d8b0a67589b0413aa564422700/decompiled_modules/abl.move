module 0x11e375b8f856efc54a2948fe691f5117d094e2d8b0a67589b0413aa564422700::abl {
    struct ABL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABL>(arg0, 9, b"ABL", b"ALBA", b"BOUTIC ALBA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1de87c4e-9e9f-403f-af00-160bca687fcd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABL>>(v1);
    }

    // decompiled from Move bytecode v6
}

