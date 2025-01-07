module 0x2751263b2ba3ae0ec9dcf8ad780a3d0fb073194cd3bdb7b36f9a700e37ba7d6b::dbuy {
    struct DBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBUY>(arg0, 6, b"DBUY", b"Don't Buy This Token", b"A meme token for the rebellious at heart! You know you shouldn't buy... but will you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dontbuylogo_93ffa605b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

