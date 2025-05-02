module 0xcdf060b4fbe33378856a4805ed79659867d3a36b24b33a58acdede109829144::usa {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 6, b"USA", b"100 % USA", b"This token is based on a meme. We are 100% USA owned.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5kdsqd3q4o4r2jtxfa5iwdm6tigpc2lp4mpcdcptt4f4ydpyyda")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

