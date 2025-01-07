module 0xd13878f9e2b6555b01ac3823624d0dce02b76d067c07c71a67ab0c90b50e5e71::meonecoin {
    struct MEONECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEONECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEONECOIN>(arg0, 9, b"MEONECOIN", b"MEONE", b"Top meme meone coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17523a9a-4f54-4183-8c50-f5b48694bc1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEONECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEONECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

