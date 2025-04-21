module 0xe1235ec228a2a2f258af99e3faa1315dd7060e3d91d25c12e77d8fa4c2429f96::mi_t {
    struct MI_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: MI_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MI_T>(arg0, 9, b"MiT", b"MiTST", b"Michitomo Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MI_T>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MI_T>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

