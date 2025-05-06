module 0xa09c54ac813dcbb3cd1d34df18a3e33a60eb3971d041623f83e8764b828937f8::housecoin {
    struct HOUSECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOUSECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOUSECOIN>(arg0, 6, b"HouseCoin", b"HousecoinSUI", b"if you hate housecoin we still love you and will crash the housing market for you to get a great entry for your family big bruh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifg6ajo3mfh7lprepbnofvhj5zi27vb32bksfl63ndt7q4p5swmm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOUSECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOUSECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

