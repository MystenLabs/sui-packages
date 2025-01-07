module 0xc2e5ecb30da521f9dd152f2cc7fc19c92f786dcdafa0ede7d45a5523edb8c337::shpb {
    struct SHPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHPB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHPB>(arg0, 6, b"SHPB", b"Sui Hungry Polar Bear", b" Hungry polarbear on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_24_24_69efe42084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHPB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHPB>>(v1);
    }

    // decompiled from Move bytecode v6
}

