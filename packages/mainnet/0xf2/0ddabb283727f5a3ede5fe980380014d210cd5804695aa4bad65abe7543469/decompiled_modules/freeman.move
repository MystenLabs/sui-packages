module 0xf20ddabb283727f5a3ede5fe980380014d210cd5804695aa4bad65abe7543469::freeman {
    struct FREEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEMAN>(arg0, 6, b"Freeman", b"SuiFreeman", x"48756579206f6e205355492120546865207265766f6c7574696f6e206973206e6f77210a506f77657220746f207468652070656f706c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003476_d561bc7a1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

