module 0x94d6e086bfa1c9eca9b3321204b2bddc32aea8af3e3830585ec2b7afba4db4f5::fkfjv {
    struct FKFJV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKFJV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKFJV>(arg0, 6, b"Fkfjv", b"Test", b"Rifif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifhuccvgigafngwfsl6a7rcp5d4yfexam2vbyyrrd2hnq3nxpgs7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKFJV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FKFJV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

