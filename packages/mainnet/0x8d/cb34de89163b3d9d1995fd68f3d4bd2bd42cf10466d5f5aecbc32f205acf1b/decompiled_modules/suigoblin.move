module 0x8dcb34de89163b3d9d1995fd68f3d4bd2bd42cf10466d5f5aecbc32f205acf1b::suigoblin {
    struct SUIGOBLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOBLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOBLIN>(arg0, 6, b"SUIGOBLIN", b"Goblin Town Sui", b"AAAAAAAUUUUUGGGHHHHH gobblins goblinns GOBLINNNNNNNNns wekm ta goblintown yoo sniksnakr DEJEN RATS oooooh rats are yummmz dis a NEFTEEE O GOBBLINGS on da BLOKCHIN wat?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_a517752ff5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOBLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOBLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

