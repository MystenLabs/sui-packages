module 0xeae7d6ef0e007779d24da146fb4f28b9d3a8f6db0b42667dba67627e58ef7010::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"TROLL", b"Troll", b"$TROLL COIN is a memebreaking cryptocurrency that embraces the spirit of internet culture. With a strong community and a renounced contract, it aims to bring laughter and fun. Join us on this exciting journey to becoming one of the top meme coins available on thy internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Movepump_6c59b5b8f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

