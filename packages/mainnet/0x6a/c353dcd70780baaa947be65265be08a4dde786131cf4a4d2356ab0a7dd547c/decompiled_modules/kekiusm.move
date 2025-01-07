module 0x6ac353dcd70780baaa947be65265be08a4dde786131cf4a4d2356ab0a7dd547c::kekiusm {
    struct KEKIUSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUSM>(arg0, 6, b"Kekiusm", b"Kekius maximus", b"We go to moon in 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003521_d17ea790fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKIUSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

