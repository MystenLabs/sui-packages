module 0x9117574d1c2b3fcfb08c46a769dd18a48123c0b305954f864d256c098f71b6d5::slow {
    struct SLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOW>(arg0, 6, b"SLOW", b"SUISLOW", b"ENEMY DOWN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_RAP_ee5a9ab00c.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

