module 0x3022c18c77badc8663af5af1a912ba8f6805b9bf9c00c5af2eb3425ef5dc65cb::h {
    struct H has drop {
        dummy_field: bool,
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H>(arg0, 9, b"H", b"DF", b"SS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a92fce7a-c216-498d-ab0c-f4f5369b491a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H>>(v1);
    }

    // decompiled from Move bytecode v6
}

