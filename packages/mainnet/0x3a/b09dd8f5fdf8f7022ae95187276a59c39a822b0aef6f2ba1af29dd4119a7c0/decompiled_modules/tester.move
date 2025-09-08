module 0x3ab09dd8f5fdf8f7022ae95187276a59c39a822b0aef6f2ba1af29dd4119a7c0::tester {
    struct TESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTER>(arg0, 6, b"Tester", b"test", b"tester coin only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicelpd4iqydjt6qhvgumgdsv55rrqm7f3xhbbqdok67nlx73ypyrq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

