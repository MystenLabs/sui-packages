module 0xb85d476e4d550b07199c661f5fd96243a8f167f15bb2299c70a9c9027c2c506d::loth {
    struct LOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTH>(arg0, 6, b"LOTH", b"SLOTH", b"Welcome to $LOTH.. where charts are optional, laziness is mandatory, and hustle culture is left to get rekt. Unapologetically slow, we dont give af about grinding or \"to-the-moon\" hype. $LOTH are busy relaxing, and roasting anyone who takes crypto too seriously.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048546_9f1ee7c559.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

