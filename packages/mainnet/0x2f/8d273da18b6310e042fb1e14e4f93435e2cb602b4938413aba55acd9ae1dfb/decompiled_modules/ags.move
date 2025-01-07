module 0x2f8d273da18b6310e042fb1e14e4f93435e2cb602b4938413aba55acd9ae1dfb::ags {
    struct AGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGS>(arg0, 9, b"AGS", b"Agusa", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0cb39a5-47a8-4185-b3fa-d0316850fcf5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

