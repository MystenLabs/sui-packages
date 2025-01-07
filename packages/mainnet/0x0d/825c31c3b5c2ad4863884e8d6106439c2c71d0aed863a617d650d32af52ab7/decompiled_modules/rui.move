module 0xd825c31c3b5c2ad4863884e8d6106439c2c71d0aed863a617d650d32af52ab7::rui {
    struct RUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUI>(arg0, 9, b"RUI", b"Ruimia", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93122c92-0255-4732-be0d-8f4f0597da93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

