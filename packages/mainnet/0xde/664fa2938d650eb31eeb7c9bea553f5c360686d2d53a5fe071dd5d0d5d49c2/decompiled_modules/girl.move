module 0xde664fa2938d650eb31eeb7c9bea553f5c360686d2d53a5fe071dd5d0d5d49c2::girl {
    struct GIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRL>(arg0, 6, b"Girl", b"girl", b"\"Girls should shine in the meme world.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738486497420.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

