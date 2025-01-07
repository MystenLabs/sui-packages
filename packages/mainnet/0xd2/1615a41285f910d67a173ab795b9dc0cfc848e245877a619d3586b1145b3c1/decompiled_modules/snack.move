module 0xd21615a41285f910d67a173ab795b9dc0cfc848e245877a619d3586b1145b3c1::snack {
    struct SNACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNACK>(arg0, 6, b"SNACK", b"Snack", b"Belgian snack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snack_3671d77b80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

