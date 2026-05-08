module 0xb00d84259eca068ce2b3e237b848a88691b687858a52209b7f2a95d04247b020::as {
    struct AS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AS>(arg0, 6, b"As", b"ASS", b"ass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicapveltevdsfedvphadw5ihjmz7srd4uaa3lh2yjcj56sqntkmce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

