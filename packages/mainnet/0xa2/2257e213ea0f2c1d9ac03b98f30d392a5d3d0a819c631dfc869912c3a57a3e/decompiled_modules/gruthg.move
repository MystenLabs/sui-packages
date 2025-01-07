module 0xa22257e213ea0f2c1d9ac03b98f30d392a5d3d0a819c631dfc869912c3a57a3e::gruthg {
    struct GRUTHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUTHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUTHG>(arg0, 6, b"GRUTHG", b"ADTHSATHSRTBH", b"AEHYESTHRSH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_11_26_12_47_49_d9c8ce39b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUTHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUTHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

