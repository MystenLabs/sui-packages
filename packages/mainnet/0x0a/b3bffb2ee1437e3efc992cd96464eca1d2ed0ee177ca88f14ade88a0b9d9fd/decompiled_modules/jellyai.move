module 0xab3bffb2ee1437e3efc992cd96464eca1d2ed0ee177ca88f14ade88a0b9d9fd::jellyai {
    struct JELLYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYAI>(arg0, 6, b"JellyAI", b"worldwarjelly", x"4a656c6c79416c2773206d697373696f6e20697320746f2070726f7669646520796f752077697468206120626574746572206675747572652e20f09f92af", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001645090.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLYAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

