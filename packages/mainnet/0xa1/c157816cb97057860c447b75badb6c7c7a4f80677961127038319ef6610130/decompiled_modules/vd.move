module 0xa1c157816cb97057860c447b75badb6c7c7a4f80677961127038319ef6610130::vd {
    struct VD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VD>(arg0, 9, b"VD", b"DS", b"XCV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ecba1f1-dc13-4f7e-8b87-5bfa93f62d37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VD>>(v1);
    }

    // decompiled from Move bytecode v6
}

