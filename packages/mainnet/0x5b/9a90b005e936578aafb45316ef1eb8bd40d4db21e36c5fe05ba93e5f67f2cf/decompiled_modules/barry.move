module 0x5b9a90b005e936578aafb45316ef1eb8bd40d4db21e36c5fe05ba93e5f67f2cf::barry {
    struct BARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRY>(arg0, 6, b"BARRY", b"BARRY SUI", b"Barny Sui is not just a meme, he Is a movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidsngc426ehfwc354foxsyh2xh7g7nkxukoz5en43ukfy4g6ltb2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

