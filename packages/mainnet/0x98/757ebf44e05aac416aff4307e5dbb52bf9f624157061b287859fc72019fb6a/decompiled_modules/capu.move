module 0x98757ebf44e05aac416aff4307e5dbb52bf9f624157061b287859fc72019fb6a::capu {
    struct CAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPU>(arg0, 6, b"CAPU", b"Ballerina Cappuccino", b"Ballerina Cappuccino Italiano", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745569106415.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

