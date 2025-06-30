module 0x1387a8349f4944c2e37eedfe6cdbc834a6df32afaacf20a8c64ddf56fb6391a::zui {
    struct ZUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUI>(arg0, 6, b"ZUI", b"ZUI ZUI", b"\"if Sui is the future, ZUI is the meme in the mirror.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidsv7rzhtikdkjvur2zj3hyjfgln7ob5ohzqsobxmjqojrr7jjuyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

