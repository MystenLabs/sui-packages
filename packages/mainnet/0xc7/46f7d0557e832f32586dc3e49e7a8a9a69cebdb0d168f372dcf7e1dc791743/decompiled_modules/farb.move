module 0xc746f7d0557e832f32586dc3e49e7a8a9a69cebdb0d168f372dcf7e1dc791743::farb {
    struct FARB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARB>(arg0, 6, b"FARB", b"Fart Baby", b"Just a Baby Fart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreial26mmpunmmbfae4l7uhv7yhstwycgb6afzceatxklivdk4cdgs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

