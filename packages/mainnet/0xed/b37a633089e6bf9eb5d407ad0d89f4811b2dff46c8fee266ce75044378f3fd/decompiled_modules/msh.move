module 0xedb37a633089e6bf9eb5d407ad0d89f4811b2dff46c8fee266ce75044378f3fd::msh {
    struct MSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSH>(arg0, 9, b"MSH", b"Mushrooms", b"Panter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87a42ae5-5dca-4690-9d43-7f70ae4727cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

