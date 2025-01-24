module 0xeaf5b9da7ab90bf4bea7cdcc3e4d8fe135ba24ac0c5e34f62c9f86652f075b17::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"Official FoxSwap", b"Were building our memecoin launch platform on Sui because its fast, scalable, and built for the future.  With low fees, high throughput, and developer-friendly tools, Sui is the perfect foundation to support viral memecoin launches and dynamic Web3 communities. Lets innovate together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_12_2762650409.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

