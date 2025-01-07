module 0x9521e02c0887bb26e129bcb177b9868dd99bed3c73716231f53d620b48a62122::m2m {
    struct M2M has drop {
        dummy_field: bool,
    }

    fun init(arg0: M2M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M2M>(arg0, 6, b"M2M", b"Mars2Musk", b"Mars2Musk (M2M) is the intergalactic currency you never knew you needed. Our mission? To meme where no coin has memed before!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735142073833.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M2M>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M2M>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

