module 0x555202093405b857dd945fa9191a7764fe76e408e98e625318472b6a08fd6378::minky {
    struct MINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINKY>(arg0, 6, b"MINKY", b"Minky", b"Hi there! Welcome to the cutest puppy on SUI. Minky meme coin king ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049036_03f9f9443a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

