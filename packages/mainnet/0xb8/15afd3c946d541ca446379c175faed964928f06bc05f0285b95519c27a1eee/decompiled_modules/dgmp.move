module 0xb815afd3c946d541ca446379c175faed964928f06bc05f0285b95519c27a1eee::dgmp {
    struct DGMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGMP>(arg0, 6, b"DGMP", b"SUIDOGBUMP", b"DOGBUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_16_fb5249247a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

