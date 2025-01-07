module 0xdbd66a2ff849b42b3c79a3681597e58704c3925c9523572b87efcf95b88f392a::susie {
    struct SUSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSIE>(arg0, 6, b"Susie", b"Susie Wiles", b"Susie Wiles is great", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731051416702.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

