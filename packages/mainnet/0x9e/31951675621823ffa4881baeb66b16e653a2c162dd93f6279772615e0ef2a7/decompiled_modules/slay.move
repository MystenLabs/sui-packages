module 0x9e31951675621823ffa4881baeb66b16e653a2c162dd93f6279772615e0ef2a7::slay {
    struct SLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAY>(arg0, 6, b"SLAY", b"Sol Slayer", b"Sui warriors slaying rug demons, battling Sol chads and maxis, while defending Suiakusa, the meme capital of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieyqzkuk5aehztkf5sprtwgos36cw5ghses22awd6swpotiwvsi3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

