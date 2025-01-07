module 0xf483d36a53443387fab4f9700d8be83def61af883cfae607dd96bcf8bd0bd7c::mxp {
    struct MXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXP>(arg0, 9, b"MXP", b"MAxPro", b"Maximum Professional", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4d14e12-1dcc-426c-9cf8-d18257ef5576.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

