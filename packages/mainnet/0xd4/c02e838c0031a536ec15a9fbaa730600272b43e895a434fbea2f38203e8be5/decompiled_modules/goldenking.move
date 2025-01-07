module 0xd4c02e838c0031a536ec15a9fbaa730600272b43e895a434fbea2f38203e8be5::goldenking {
    struct GOLDENKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDENKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDENKING>(arg0, 6, b"GOLDENKING", b"Golden King", b"The Trump is here to make crypto greate again ! Join the party with Golden King", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flat_750x_075_f_pad_750x1000_f8f8f8_u7_1_a211e35697.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDENKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDENKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

