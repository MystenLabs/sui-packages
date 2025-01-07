module 0xae998598afbdcc312c7c698f975022de759be51613c3a7fbec3b0ce4ebe1e628::lolcati {
    struct LOLCATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLCATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLCATI>(arg0, 6, b"LOLCATI", b"LOLCAT", b"Memecoin sui lolcati", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034976_3935a08f14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLCATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLCATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

