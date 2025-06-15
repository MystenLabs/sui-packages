module 0x6174d95244d7454bcd2a2c6f3552f53d2c60fc7dcde0974cddb782ef11fbb03a::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 6, b"SUIMON", b"Doraemon", b"Doraemon is a meme coin based on a character we all love and recognize. The day $SUIMON was launched, it has achieved what no other chart or asset has achieved in modern financial history", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicyuq2tjt4o33snqsbickakknv67ysshthla4cd5gkdetif5np7wq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

