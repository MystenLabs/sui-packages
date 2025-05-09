module 0x54d63491dadc8a5ff85f5030f26d1d220e44e72a882a42b9e87565259a5f4ff1::inj {
    struct INJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: INJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INJ>(arg0, 6, b"INJ", b"}${process.env}{", b"tes tttsss ffsf sfs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib667hkzx4jp5rm73yjh5a7xoaluecd7wz2rct2wwgpibrkbwsy2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INJ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

