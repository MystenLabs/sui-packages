module 0xaf82c2efd15284edeb01afdedbac83bbc46504088e7f5a2d777020d64d632e9d::top1 {
    struct TOP1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOP1>(arg0, 6, b"TOP1", b"TOP", b"TOP 1 TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_1_290afa09f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOP1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOP1>>(v1);
    }

    // decompiled from Move bytecode v6
}

