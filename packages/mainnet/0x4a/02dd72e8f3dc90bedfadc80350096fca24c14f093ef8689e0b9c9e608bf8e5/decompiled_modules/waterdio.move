module 0x4a02dd72e8f3dc90bedfadc80350096fca24c14f093ef8689e0b9c9e608bf8e5::waterdio {
    struct WATERDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERDIO>(arg0, 6, b"WATERDIO", b"WATERD", x"24574154455244494f206d616b65732065766572797468696e672067726f772e0a0a416674657220616c6c2c206576656e207468652053756920636861696e20737461727473207769746820612077617465722064726f7021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xb713342104cd25efe0333e481d1caf2c3650b258ec3f3a0b3f6765cd3582624b_water_water_1_58053b9c47.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

