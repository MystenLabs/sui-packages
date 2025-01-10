module 0xf2d4bfff0471a3995c6ecbfc85851db78c5edf5ce031b423a42156d2daa294a4::bart {
    struct BART has drop {
        dummy_field: bool,
    }

    fun init(arg0: BART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BART>(arg0, 6, b"BART", b"Bartman Meme", b"Vibes which you still crave for and multiply your investment in safe mode. Don't you miss nostalgia 2d games? #BART came to bring those feelings back!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_5d2ac4b642.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BART>>(v1);
    }

    // decompiled from Move bytecode v6
}

