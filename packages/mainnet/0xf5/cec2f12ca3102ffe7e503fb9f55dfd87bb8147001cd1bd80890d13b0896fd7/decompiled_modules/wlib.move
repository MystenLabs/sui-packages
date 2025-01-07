module 0xf5cec2f12ca3102ffe7e503fb9f55dfd87bb8147001cd1bd80890d13b0896fd7::wlib {
    struct WLIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLIB>(arg0, 6, b"WLIB", b"World Liberty", b"Making liberty great again, courtesy of the one and only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma7p_Ay_Rc_Si3_Wn_N_Xyfuuaywtvj_V4tm_Hn6uh_CDLW_1nxj7_LG_a0f91ddf51.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

