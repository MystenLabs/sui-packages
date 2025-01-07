module 0xa136cbec1d5d435bf7d1e000f038d8c20707328a0e2f92ed38e5693abcbdbe34::smonster {
    struct SMONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMONSTER>(arg0, 6, b"SMonster", b"Monster", b"Pure meme, witness the highlights of the future together, and more and more people will join us to build together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012857_1b0564256f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMONSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

