module 0xfeb7fc11c7d64718d2c0d31555c2aaa644525df742f36ea9af2b899e5403e30a::bang {
    struct BANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANG>(arg0, 6, b"BANG", b"BANANA GANG", b"Building a unique Play-to-Earn game on the Sui blockchain. All in-game assets are NFTs, and the economy is fueled by our native meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1756745501726.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

