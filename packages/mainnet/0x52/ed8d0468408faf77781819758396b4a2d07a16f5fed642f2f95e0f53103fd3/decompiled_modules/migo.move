module 0x52ed8d0468408faf77781819758396b4a2d07a16f5fed642f2f95e0f53103fd3::migo {
    struct MIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGO>(arg0, 6, b"MIGO", b"Amigos coin", b"The Amigos meme coin on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731088489523.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

