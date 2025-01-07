module 0xc9e3bf297f66a4cc0fe93b9f30ad1556a2ef0863ae2622d5d67c9a6e04a1aae4::sizzly {
    struct SIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZZLY>(arg0, 6, b"SIZZLY", b"SUIZZLY", x"53495a5a4c5920746865206368756262792062656172206f6e2061206d697373696f6e20666f7220656e646c65737320686f6e657920286761696e7329210a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/grizz_dancing_by_suzettecharlotte_ddb9t5y_fullview_1de04cceb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

