module 0x46c6b9f71fe6449a855a3c0f94a1a7565ad8552c695ba9e68e533bd799c42a4d::jas {
    struct JAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAS>(arg0, 6, b"JAS", b"JUST SOUL", b"BE WHO YOU ARE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_508aec74f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

