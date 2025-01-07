module 0x10b3c377746aca9a0a0b1119c5f1ebd8770441bc66cb5d3dc0148a5c1870cbc7::cycle {
    struct CYCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYCLE>(arg0, 6, b"CYCLE", b"SUICYCLE", b"SUICYCLE Bycycle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zzz_d682d21c63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

