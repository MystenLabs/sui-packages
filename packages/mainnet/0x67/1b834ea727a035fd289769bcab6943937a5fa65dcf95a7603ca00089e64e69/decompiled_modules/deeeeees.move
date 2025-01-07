module 0x671b834ea727a035fd289769bcab6943937a5fa65dcf95a7603ca00089e64e69::deeeeees {
    struct DEEEEEES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEEEEES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEEEEES>(arg0, 6, b"DEEEEEES", b"DEXS", b"HI GUYS IM HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dexscr_8d9bbd9e94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEEEEES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEEEEES>>(v1);
    }

    // decompiled from Move bytecode v6
}

