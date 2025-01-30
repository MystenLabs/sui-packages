module 0xe6b8fadc1cb02e1c027820145bb4092f181fefba8debed05068fe86bdc5a03da::zigzag {
    struct ZIGZAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIGZAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIGZAG>(arg0, 9, b"ZIGZAG", b"Sam Lessin's Horse ", b"My horse Zig Zag is now officially available to breed...  bring your mare, he performs better than his name.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbuCV85f1MRYairZicdJUzrGhpR94HPP6efYYK8MQxmkT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZIGZAG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIGZAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIGZAG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

