module 0x6ba284d22366ae66baa4ee07f33db53b908e45c559046a2d9cea02e5657c3252::adrianna {
    struct ADRIANNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADRIANNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADRIANNA>(arg0, 6, b"Adrianna", b"Adrianna Dottwoman", b"ELON MUSK'S FEMALE ALTER EGO. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adrian_78af64eba5.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADRIANNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADRIANNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

