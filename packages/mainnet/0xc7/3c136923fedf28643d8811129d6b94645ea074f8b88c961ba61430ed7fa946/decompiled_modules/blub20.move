module 0xc73c136923fedf28643d8811129d6b94645ea074f8b88c961ba61430ed7fa946::blub20 {
    struct BLUB20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB20>(arg0, 6, b"BLUB20", b"BLUB 2.0 SUI", x"41204469727479204669736820322e302020696e2074686520576174657273206f662074686520537569204f6365616e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_0_c7075e5cb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB20>>(v1);
    }

    // decompiled from Move bytecode v6
}

