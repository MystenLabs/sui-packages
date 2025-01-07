module 0xfb8bb52a8c0ecbd65b2149c1dc3b5cd85a7f8bdaaf992e708447484a293d77ec::kleus {
    struct KLEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLEUS>(arg0, 6, b"KLEUS", b"Kleus | Klaus's Girlfriend", b"$KLEUS  KLAUSs ride-or-die, the Bonnie to his Clyde, the peanut butter to his jelly, and the meme queen to his meme king! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056942_c6b084eb72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

