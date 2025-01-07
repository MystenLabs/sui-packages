module 0x2b66864c57bb18879a766f810260b75d28320365f5d09c3ea0e72ae7fbea5d81::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BUBL>(arg0, 7481717131991191456, b"BUBL ON SUI", b"BUBL", b"Bubbling on Sui Network.", b"https://images.hop.ag/ipfs/QmZYeU4eSDkWSMjoDLTjmvrc1ZQYdjUFPQ8x7NxWvpHdkA", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://bublsui.com/"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

