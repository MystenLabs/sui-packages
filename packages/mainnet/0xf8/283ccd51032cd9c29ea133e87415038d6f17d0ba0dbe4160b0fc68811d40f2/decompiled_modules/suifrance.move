module 0xf8283ccd51032cd9c29ea133e87415038d6f17d0ba0dbe4160b0fc68811d40f2::suifrance {
    struct SUIFRANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFRANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFRANCE>(arg0, 6, b"SuiFrance", b"official Sui France", x"426c6f636b636861696e206465204c61796572203120636f6e756520706f757220676172616e74697220756e6520706f7373657373696f6e2064616374696673206e756d726971756573207261706964652c2070726976652c20736375726973652065742061636365737369626c652020746f75732e205477697474657220616666696c6920200a40537569466f756e646174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1742323003832_210b719f5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFRANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFRANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

