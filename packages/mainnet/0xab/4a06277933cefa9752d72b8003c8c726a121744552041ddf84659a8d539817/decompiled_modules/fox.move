module 0xab4a06277933cefa9752d72b8003c8c726a121744552041ddf84659a8d539817::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"Official FoxSwap", b"Were building our memecoin launch platform on Sui because its fast, scalable, and built for the future.  With low fees, high throughput, and developer-friendly tools, Sui is the perfect foundation to support viral memecoin launches and dynamic Web3 c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737683209408.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

