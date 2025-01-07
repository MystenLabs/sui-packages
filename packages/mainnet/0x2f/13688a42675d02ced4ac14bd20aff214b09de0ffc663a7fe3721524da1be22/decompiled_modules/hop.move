module 0x2f13688a42675d02ced4ac14bd20aff214b09de0ffc663a7fe3721524da1be22::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", b"Hop Aggregator", b"Swap on @SuiNetwork for the best price with zero fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_03_045336_637d2ec2cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

