module 0x3f940ff72e57bcf7ebbdc025126ea17aac2bf322836bb93d915b9443ad693365::avca {
    struct AVCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVCA>(arg0, 6, b"AVCA", b"AVCAA", b"AVCA 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moonlitebot_x_rachop_44557d1a64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

