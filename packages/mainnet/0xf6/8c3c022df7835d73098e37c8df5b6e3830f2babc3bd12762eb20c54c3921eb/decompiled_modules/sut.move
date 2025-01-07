module 0xf68c3c022df7835d73098e37c8df5b6e3830f2babc3bd12762eb20c54c3921eb::sut {
    struct SUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUT>(arg0, 6, b"SUT", b"SUITRUMP 2", b"Surf the SUI wave with SUITRUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nv_IM_1g7v_400x400_1_51d85b2818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

