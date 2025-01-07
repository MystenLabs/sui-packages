module 0x5a3f80b16cd7e66973366e0acde3598df15aa23841c6bc0c5795efd1b01c51dd::xai {
    struct XAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAI>(arg0, 9, b"XAI", b"Xai Memes", b"MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmXVRmyotXfz5zSNmSM6Ao4qmmsry9CF5fsowYzZHxgSvP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

