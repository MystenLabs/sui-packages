module 0xaa4d106b0223715b7f8241f43ec4a81225db55a5d1f955a904dadcb91ea56dde::mdf {
    struct MDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MDF>(arg0, 6, b"MDF", b"My dog friend by SuiAI", x"4d7920676f6c64656e20726574726965766572204920666f756e64206974206974e2809973206c6974746c65206d79206d6f7374206c6f76656420667269656e6420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0238_839e3b4695.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MDF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

