module 0x550b3949cc7b05cd83935552812a85d427dddb7885295a213b32c68e9e11f31d::gen {
    struct GEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEN>(arg0, 9, b"GEN", b"Genesis", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8cc4c08-3abb-4f2f-a6ec-968ef639a86a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

