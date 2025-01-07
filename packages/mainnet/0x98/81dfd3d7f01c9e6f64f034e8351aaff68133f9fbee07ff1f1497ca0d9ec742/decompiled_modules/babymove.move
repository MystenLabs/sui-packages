module 0x9881dfd3d7f01c9e6f64f034e8351aaff68133f9fbee07ff1f1497ca0d9ec742::babymove {
    struct BABYMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMOVE>(arg0, 6, b"BabyMove", b"Baby Move PUMP", b"Little baby pump your bagg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baby_move_pump_abe0f5d8bc_21d6083551.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

