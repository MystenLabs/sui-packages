module 0xae4f286e0c171a036b70719e0e9da60cd50287e1b459d42daf4b2764b2536adc::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 6, b"DOUG", b"Doug", b"Meet $DOUG, the DOG. With the longest nose on SUI and BRETT-Level TOP-TIER designs, $DOUG is ready to WOOF at his competitors and rally to the MOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Doug_Logo_8c7e52040b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

