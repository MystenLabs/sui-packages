module 0xf0f52ba5439d1c3404b3bed726c9e645f7b84cf40ad87b619f2474d470610ff6::spve {
    struct SPVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPVE>(arg0, 6, b"SPVE", b"PVE", b"Please stop the PVP behavior; let's work together to grow stronger and achieve greatness.PVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_14_07_15_14_488bc27eec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

