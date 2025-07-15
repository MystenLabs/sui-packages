module 0xe7f32b8995171a9a67353a029f31b0e51d6231d9325f4501d8de6ca4495a738b::HBD {
    struct HBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBD>(arg0, 6, b"HABADIS", b"HBD", b"You don't get it. It's not like that", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

