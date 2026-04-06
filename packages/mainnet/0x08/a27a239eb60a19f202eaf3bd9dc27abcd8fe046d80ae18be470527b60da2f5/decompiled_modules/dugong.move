module 0x8a27a239eb60a19f202eaf3bd9dc27abcd8fe046d80ae18be470527b60da2f5::dugong {
    struct DUGONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUGONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUGONG>(arg0, 6, b"DUGONG", b"DUGONG SUI", b"DUGONG coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxzdp7wvvblwo4jvnrugktvwaqnhzquxduskl25aig5ugsbehpxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUGONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUGONG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

