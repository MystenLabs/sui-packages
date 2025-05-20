module 0x4e7a6e3b2c686d5c5cae65fd2cbf667eadda053840e0a39d8156a398595abf33::aquan {
    struct AQUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAN>(arg0, 6, b"AQUAN", b"AQUANITE SUI", b"tiny project artwork seek pretty hidden art casual shuffle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab4x47f44jig6e2zqbagkvbpeivuhghw6k7eomrcs4dpwd4gvms4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

