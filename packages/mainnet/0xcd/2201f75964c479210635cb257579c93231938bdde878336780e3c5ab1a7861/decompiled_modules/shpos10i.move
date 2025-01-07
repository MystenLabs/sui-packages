module 0xcd2201f75964c479210635cb257579c93231938bdde878336780e3c5ab1a7861::shpos10i {
    struct SHPOS10I has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHPOS10I, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHPOS10I>(arg0, 6, b"SHPOS10I", b"HPOS10I SUI", b"Parodical satirical multifaceted meme project *not affiliated with Harry Potter, Sega or Obama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BITCOIN_19e92da0b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHPOS10I>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHPOS10I>>(v1);
    }

    // decompiled from Move bytecode v6
}

