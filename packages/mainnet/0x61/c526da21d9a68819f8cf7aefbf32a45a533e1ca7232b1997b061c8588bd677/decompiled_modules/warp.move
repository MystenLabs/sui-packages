module 0x61c526da21d9a68819f8cf7aefbf32a45a533e1ca7232b1997b061c8588bd677::warp {
    struct WARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARP>(arg0, 6, b"WARP", b"Warp On Sui", b"Warp is more than just a meme coinit's a journey into the future of decentralized creativity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002818_2c22f6d425.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

