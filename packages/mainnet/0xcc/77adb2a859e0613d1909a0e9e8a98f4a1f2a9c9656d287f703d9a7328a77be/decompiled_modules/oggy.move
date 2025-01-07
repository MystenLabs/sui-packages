module 0xcc77adb2a859e0613d1909a0e9e8a98f4a1f2a9c9656d287f703d9a7328a77be::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 6, b"OGGY", b"Oggy The Cat", b"In the vast expanse of the memeiverse, Oggy reigns supreme as the purr-fect embodiment of feline wit and wisdom. With $OGGY as his calling card, he invites you to join him on a journey filled with laughter, love, and plenty of meme-worthy moments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/65161382_652435525184445_7012340031268323328_n_09_16_25_16_f71380de1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

