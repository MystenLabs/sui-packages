module 0xddfb5e86ff41d7da22355c8a4b2fb3e30242d84c6cf610dae6bb03debbdc5198::bv {
    struct BV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BV>(arg0, 6, b"BV", b"aaaaa", b"ASSSSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih2irotbkhmuwmavm37e7eki22zgg6po5dw33iegu6gfstbp2gbgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

