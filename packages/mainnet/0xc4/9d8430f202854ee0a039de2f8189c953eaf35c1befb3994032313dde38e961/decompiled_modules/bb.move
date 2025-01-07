module 0xc49d8430f202854ee0a039de2f8189c953eaf35c1befb3994032313dde38e961::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 6, b"BB", b"BOSSBLUB", b"No meme does it like the BOSSBLUB. Hell show what makes a great meme coin. With super blub , the BOSSBLUB is building a meme kingdom that will grow . ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_optimized_500_e1304d0362.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BB>>(v1);
    }

    // decompiled from Move bytecode v6
}

