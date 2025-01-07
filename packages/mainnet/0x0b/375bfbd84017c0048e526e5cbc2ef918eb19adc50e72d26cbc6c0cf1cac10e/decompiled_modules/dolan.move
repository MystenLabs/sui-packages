module 0xb375bfbd84017c0048e526e5cbc2ef918eb19adc50e72d26cbc6c0cf1cac10e::dolan {
    struct DOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAN>(arg0, 6, b"DOLAN", b"dolan duck", b"Look at mi, an udderly malishus duc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U9w_In7_NX_400x400_97ea0523b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

