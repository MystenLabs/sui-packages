module 0x3766e534b5dc6cdb7defd998debf19f72565f4a7b8224e36b050f690b71a8819::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 6, b"BOOM", b"Boom Bots AI", b"200 pixel-art tanks on Sui that auto-battle every night at 12 AM GMT unique AI strategies, balanced traits, and daily $BOOM token rewards for the victor. Mint yours on TradePort and join the arena!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidcrjtdybxdkgxbi55ghmwpkcxkj2gwvzgchqx6ht2xxrqmatnfsi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

