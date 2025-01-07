module 0xf43c5ab9d78c70d4d34d145510441d3abef5785fb93157311d25cb269433f739::harold {
    struct HAROLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAROLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAROLD>(arg0, 6, b"HAROLD", b"The Hermit Crab", b"Harold, a curious hermit crab, found a magical shell that let him communicate with sea creatures through hidden currents. With this power, he traded stories and treasures, becoming a legend and guardian of the ocean's secrets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_21_15_08_d0335cfb1a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAROLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAROLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

