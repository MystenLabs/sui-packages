module 0x83643d85cc11682eadfa9397788124b3d137fa39b6ad0c5650f1ca78c3aa5b8d::suilion {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 6, b"SUILION", b"Suilion", b"A colony of suilions is now on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilion_4c024db77b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILION>>(v1);
    }

    // decompiled from Move bytecode v6
}

