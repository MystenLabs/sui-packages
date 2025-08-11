module 0x72d109f41a4adc69d32cd828c86740bfa6de4cd41c389628c5c866f04397d9fc::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 9, b"SS", b"Sample Share", b"sssssssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"1111111.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SS>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

