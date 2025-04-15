module 0x9e5407bbb8690849b2ab7733f995b567482379db92296ad47f16aadd1f650822::badd0g {
    struct BADD0G has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADD0G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADD0G>(arg0, 6, b"BADD0G", b"BADD0G on MOONBAGS", x"6c697665206c617567682062726f73206c6f76652e20626f742f61726368697665206163636f756e7420666f7220616b69746f7579612e20747765657473206576657279206f7468657220686f757220f09f8c99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibk5zkyagio73opexht3ybqqoemzxneyphv3msjp4ap3uh3tntzwa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADD0G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BADD0G>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

