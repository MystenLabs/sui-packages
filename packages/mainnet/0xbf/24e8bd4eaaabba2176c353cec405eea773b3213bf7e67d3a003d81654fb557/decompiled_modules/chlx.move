module 0xbf24e8bd4eaaabba2176c353cec405eea773b3213bf7e67d3a003d81654fb557::chlx {
    struct CHLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLX>(arg0, 6, b"CHLX", b"CHILLAXO", b"\"Chill Axo\" is a collection of 2222 quirky and adorable axolotls living in the tranquil paradise of Axolotl Oasis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHLX_TOKEN_ICON_5660b6c53d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

