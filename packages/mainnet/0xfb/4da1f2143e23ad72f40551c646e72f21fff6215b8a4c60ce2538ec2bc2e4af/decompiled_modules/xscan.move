module 0xfb4da1f2143e23ad72f40551c646e72f21fff6215b8a4c60ce2538ec2bc2e4af::xscan {
    struct XSCAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSCAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSCAN>(arg0, 6, b"XSCAN", b"X SCAN", b"X SCAN is a cutting-edge tool built for Binance enthusiasts, empowering communities to stay ahead in real time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifuwgrju5h2udbrkfel5bbpahd7g5zzrd3rg5uif2ntrlpbblqe5m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSCAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XSCAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

