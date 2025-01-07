module 0x5a80b50dcd9b98b8448b11b7704843f1f2157c6a2dd767e7ee92650e2ef0ea8a::chillfish {
    struct CHILLFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLFISH>(arg0, 6, b"CHILLFISH", b"Just a chill fish", b"Literally just a chill fish. I'll make tg if there's any traction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000061_21330221f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

