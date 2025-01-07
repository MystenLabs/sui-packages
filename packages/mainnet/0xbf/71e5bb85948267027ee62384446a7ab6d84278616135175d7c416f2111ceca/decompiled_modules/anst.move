module 0xbf71e5bb85948267027ee62384446a7ab6d84278616135175d7c416f2111ceca::anst {
    struct ANST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANST>(arg0, 6, b"ANST", b"ANON", b"Test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/copy11_69f73beb5c_ed732e4af0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANST>>(v1);
    }

    // decompiled from Move bytecode v6
}

