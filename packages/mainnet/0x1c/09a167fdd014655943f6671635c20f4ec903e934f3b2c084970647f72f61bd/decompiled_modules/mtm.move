module 0x1c09a167fdd014655943f6671635c20f4ec903e934f3b2c084970647f72f61bd::mtm {
    struct MTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTM>(arg0, 9, b"MTM", b"Official Mars2Musk Token", b"Meme token of Mars 2 Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mars2musk.com/wp-content/uploads/elementor/thumbs/Untitled-250-x-250-px-qvmd5lzdb0kkyqygd1m2zsf5ot7pwbiiend5hcdwbs.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MTM>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

