module 0x9a6f3acb5f8e78e7f03c83fb94fed78e1e782af73e78b9475341a92d541756ba::suitard {
    struct SUITARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARD>(arg0, 6, b"SUITARD", b"SUITARDS", x"546865206f6e6c79207265616c205355495441524453206f6e20537569204e6574776f726b2e2046726f6d206d656d657320746f205046507320616e64204e4654732e204a6f696e2074686520636c75622e200a0a4e46542064726f7073206f6e205472616465706f7274202d204e465420726576656e75652077696c6c206265207573656420746f206275796261636b20245355495441524420746f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibw2yzcci7lvncxvlhfq6ghbny65hmkzzw5mzgu4isy7jmulhrkwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

