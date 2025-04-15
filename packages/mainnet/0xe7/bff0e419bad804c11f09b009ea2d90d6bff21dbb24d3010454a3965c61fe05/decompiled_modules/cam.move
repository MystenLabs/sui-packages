module 0xe7bff0e419bad804c11f09b009ea2d90d6bff21dbb24d3010454a3965c61fe05::cam {
    struct CAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAM>(arg0, 6, b"CAM", b"Campuchia", b"campuchia world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiegt4psp6tth6vqhw6u52chryrlm46rlt44zgmqz77wnqekp5f3zy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

