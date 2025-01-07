module 0x8d2a273c7f913427b1f631a424ba0a64cac4b314d88635bdb876418ae1bae672::cj {
    struct CJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJ>(arg0, 6, b"CJ", b"CJ on Sui", b"Ah shit, here we go again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006062_6dc0afef3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

