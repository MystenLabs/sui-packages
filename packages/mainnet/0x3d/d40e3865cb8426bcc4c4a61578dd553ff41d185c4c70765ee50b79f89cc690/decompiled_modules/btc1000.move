module 0x3dd40e3865cb8426bcc4c4a61578dd553ff41d185c4c70765ee50b79f89cc690::btc1000 {
    struct BTC1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC1000>(arg0, 6, b"BTC1000", b"BTC100K", b"Just a beginning!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038931_cdf58130b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC1000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC1000>>(v1);
    }

    // decompiled from Move bytecode v6
}

