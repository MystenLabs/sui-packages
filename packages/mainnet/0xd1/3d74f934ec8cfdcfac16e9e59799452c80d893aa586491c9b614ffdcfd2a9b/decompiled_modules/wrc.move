module 0xd13d74f934ec8cfdcfac16e9e59799452c80d893aa586491c9b614ffdcfd2a9b::wrc {
    struct WRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRC>(arg0, 9, b"WRC", b"WorldRescu", b"Your next 1000* coin a new innovation for global economic boast and realestate investment ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e01f216-ac2f-469a-8259-3e73c4418493.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

