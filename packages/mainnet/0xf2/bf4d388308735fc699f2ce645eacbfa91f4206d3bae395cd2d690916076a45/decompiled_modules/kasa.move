module 0xf2bf4d388308735fc699f2ce645eacbfa91f4206d3bae395cd2d690916076a45::kasa {
    struct KASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASA>(arg0, 6, b"KASA", b"KASAS", b"KASSA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1a1c40bb_63b7_45ee_9e86_7808c431721b_qui8_Sd_DO_400x400_ce95b3235c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

