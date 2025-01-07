module 0xe15a74afc2c0c0dec04595c4773b45a2447795dd38ede1ac3c9fec3ea2d58739::hdp {
    struct HDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDP>(arg0, 6, b"HDP", b"Fuck hop on sui", b"hop rug time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_02_12_12_45_79f62fb96f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

