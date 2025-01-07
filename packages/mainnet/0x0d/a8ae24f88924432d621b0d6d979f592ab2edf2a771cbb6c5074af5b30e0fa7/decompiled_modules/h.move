module 0xda8ae24f88924432d621b0d6d979f592ab2edf2a771cbb6c5074af5b30e0fa7::h {
    struct H has drop {
        dummy_field: bool,
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H>(arg0, 9, b"H", b"Hebi", b"Hebi the snack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0988a660-a2a5-4129-82f8-84f2ee530158.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H>>(v1);
    }

    // decompiled from Move bytecode v6
}

