module 0x820c843848ba7693dbecfd5b2d62f782b537394835f72a6b22cdeab830c79663::nobelist {
    struct NOBELIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBELIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBELIST>(arg0, 6, b"Nobelist", b"Han Kang", b"dedicate to 2024 Novelist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013898_8ce650c556.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBELIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBELIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

