module 0xe015a39cd0a9a269cc95c618b9e6f5bc9a8a9cdeb1c42757fb8beb451a6da946::hole {
    struct HOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLE>(arg0, 6, b"HOLE", b"BLACKHOLE SUI", b"BLACKHOLE SUI ($HOLE) is a decentralized meme coin built on the Sui blockchain. As a pure meme project, $HOLE aims to entertain and engage the crypto community with humorous and often absurd themes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_62f9dc856a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

