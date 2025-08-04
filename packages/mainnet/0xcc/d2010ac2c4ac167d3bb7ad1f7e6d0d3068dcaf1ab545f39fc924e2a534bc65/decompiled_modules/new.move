module 0xccd2010ac2c4ac167d3bb7ad1f7e6d0d3068dcaf1ab545f39fc924e2a534bc65::new {
    struct NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW>(arg0, 9, b"NEW", b"Newmoney Wallet", b"The only AI-Powered Crypto and Cash Wallet. Hold, swap, send, buy and sell crypto on Sui, Solana, Bitcoin, XRP, EVM and more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1934637689053106176/G-fqnxcG_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEW>>(0x2::coin::mint<NEW>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEW>>(v2);
    }

    // decompiled from Move bytecode v6
}

