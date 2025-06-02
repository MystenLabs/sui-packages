module 0xf2491524e6279a54a5466b3c6942b4ececb23cf8080471333e748d615109bbc3::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 6, b"SUPER", b"SUPERSUI", b"Welcome to SuperSui, Where memes go supercharged.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreido3fv5zifb6juajtje67ezn6sgz4zsttzgizrx4cfxqg4vm55nd4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

