module 0x1a468b87b324526299d360b8d859fa4b8925c9970f490c2612c04d1bc551cd4a::suu {
    struct SUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUU>(arg0, 6, b"SUU", b"Ovan On Turbos", b"Ovan Ovan Ovan Ovan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956263134.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

