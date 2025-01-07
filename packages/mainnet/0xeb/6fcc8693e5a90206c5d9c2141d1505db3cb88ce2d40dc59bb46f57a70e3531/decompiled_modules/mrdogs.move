module 0xeb6fcc8693e5a90206c5d9c2141d1505db3cb88ce2d40dc59bb46f57a70e3531::mrdogs {
    struct MRDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRDOGS>(arg0, 6, b"MRDOGS", b"Mr Dogs", b"Mr. Dogs is the boss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_f25b761c62.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

