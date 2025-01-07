module 0xc3baee2815c4a36214b57ab050700f730c657ce40edc4bb2bd330b8f7a187caf::btr {
    struct BTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTR>(arg0, 9, b"BTR", b"BornToRich", x"4a757374206d656d6520666f7220676f6f64206c69766520f09f9881", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e1e981c-153c-4da7-a6cb-cddc926d676e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

