module 0xd1b91fdfb84a01c30c233b1ff385b835f360a68066fa7601f8c7b4874cd078b6::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 6, b"OINK", b"Oink", b"There is only one true way to call in the hogs for chow time: SUUU-IIII!!!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/327_CEDC_1_C8_C7_41_E5_A02_C_D1_C2512102_F7_9ce887a56e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

