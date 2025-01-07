module 0x93dbfc12a71f92ea897ca6ac5b2af9979794dab7fc35c56b83606cfdc25599e9::syro {
    struct SYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYRO>(arg0, 6, b"SYRO", b"SUIRO CTO", b"CTO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_15_12_36_6a04d6fef2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

