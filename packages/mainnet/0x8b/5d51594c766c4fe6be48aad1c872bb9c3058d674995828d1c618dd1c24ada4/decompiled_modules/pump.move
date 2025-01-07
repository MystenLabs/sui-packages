module 0x8b5d51594c766c4fe6be48aad1c872bb9c3058d674995828d1c618dd1c24ada4::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"PUMP TOKEN", b"Lets PUMP it..!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_31_at_3_52_22a_PM_e56d3b2fdc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

