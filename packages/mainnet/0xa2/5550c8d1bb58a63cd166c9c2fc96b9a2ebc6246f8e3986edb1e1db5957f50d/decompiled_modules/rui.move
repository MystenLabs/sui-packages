module 0xa25550c8d1bb58a63cd166c9c2fc96b9a2ebc6246f8e3986edb1e1db5957f50d::rui {
    struct RUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUI>(arg0, 9, b"RUI", b"Ruimia", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b26a695a-3c5c-44ab-ab19-9578b6e1d6ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

