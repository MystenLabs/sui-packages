module 0x2532d037e5fe807e00d7bd3d0eb79ef495600ec167e5bc2efecf47ceb3740a2d::jm {
    struct JM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JM>(arg0, 9, b"JM", b"janggom", b"11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a64c452-d681-40cc-afe4-93046d549697.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JM>>(v1);
    }

    // decompiled from Move bytecode v6
}

