module 0x565fac7444355c86cf603b2594e2ad779d90811b507fe4fb9528e465e2d0e4c5::memeonsui {
    struct MEMEONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEONSUI>(arg0, 6, b"MEMEONSUI", b"SUIMEH", b"The embodiment of apathy in the meme coin universe, the ultimate crypto degen, emotionless in the face of chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985866010.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEONSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

