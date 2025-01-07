module 0x2c0d271fabeeb0521187f475289fd8fecd6e259ee136a16fe5558f3c29eecb14::suidrop {
    struct SUIDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDROP>(arg0, 6, b"SUIDROP", b"SUIDROP TOKEN", b"BUY FOR DROP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sui_logo_Large_9328526268.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

