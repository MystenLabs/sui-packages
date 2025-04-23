module 0xd69254d98c262b34937402355c90662af8e0cf1a627f2f59aa926f0f5471022b::rpdc {
    struct RPDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPDC>(arg0, 6, b"RPDC", b"RepublicanPlanDotCom", b"https://republicanplan.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745432710895.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RPDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

