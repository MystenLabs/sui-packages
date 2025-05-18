module 0x5135e3c91c40ad5b84ee5b7c8880209d7ffc5fe6107e9ac98db75990da8f0fed::sagicoin {
    struct SAGICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGICOIN>(arg0, 9, b"SAGICOIN", b"sagi", x"426c6f636b636861696e2d6261736564206d756c7469706c6179657220616476656e747572652e20506c61792c206561726e2c206f776e2e20506f77657265642062792024534147492e0a235361676947616d6520234e46542023506c6179546f4561726e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/31beefd202ce0cb6cf8f5c6f1a3de06bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAGICOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGICOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

