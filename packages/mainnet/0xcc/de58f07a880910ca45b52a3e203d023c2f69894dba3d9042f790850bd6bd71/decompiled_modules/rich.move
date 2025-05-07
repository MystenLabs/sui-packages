module 0xccde58f07a880910ca45b52a3e203d023c2f69894dba3d9042f790850bd6bd71::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 6, b"Rich", b"Trying rich", b"This is rich not poor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiejdr4w2lww33l7si6gja7egplcpyc6cwnwwii4xvsrb7s76iw7ni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RICH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

