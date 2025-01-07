module 0x892e8480d87f0e3ace3612eebf22660282448f76174386c068c575180e01227::lewis {
    struct LEWIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEWIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEWIS>(arg0, 6, b"LEWIS", b"Lewis the Goose", x"6c69746572616c6c79206a757374206120676f6f7365206f6e2073756920717561636b20717561636b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lewis_the_Goose_3403e575e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEWIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEWIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

