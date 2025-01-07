module 0x40a15ed79ec6b10c0d1c576ef8d41ed7100d7f46cb314d1f97a230b7a9f46ca2::gonk {
    struct GONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONK>(arg0, 6, b"GONK", b"Gonk The Alien", b"Who is Gonk? Gonk is a space alien from the distant planet Nebulon! This vibrant world, galaxies away, has fallen to bears. Desperate to find bulls, he lands on Earth, awaiting the next bull run.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048668_25e51b1462.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

