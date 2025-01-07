module 0x9a4527131518df69796dd5df8eaaba9e6dcdff98693c72ff4c7fc42d4430ba::betty {
    struct BETTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETTY>(arg0, 6, b"BETTY", b"Betty on Sui", b"Betty sui take a brett", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050422_7c01b7d235.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

