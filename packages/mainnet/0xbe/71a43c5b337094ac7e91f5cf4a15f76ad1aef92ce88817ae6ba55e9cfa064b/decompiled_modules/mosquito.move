module 0xbe71a43c5b337094ac7e91f5cf4a15f76ad1aef92ce88817ae6ba55e9cfa064b::mosquito {
    struct MOSQUITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSQUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSQUITO>(arg0, 9, b"MOSQUITO", b"msq", b"Mosquito is an organized meme coin that will be the meme coin of the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98ebf7a1-ebd3-4cb9-b0b2-5f7284051cd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSQUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSQUITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

