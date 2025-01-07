module 0xd4ed4932160bd087d2422088470301fe6d09a82b3b863b2ae1a1012f962fa68f::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 9, b"MAN", b"Cu man", x"59c3aa7520646f69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a39412da-c78c-47dc-aef3-0086bccb4135.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

