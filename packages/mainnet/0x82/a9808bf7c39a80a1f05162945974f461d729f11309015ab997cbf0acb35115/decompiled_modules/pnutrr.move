module 0x82a9808bf7c39a80a1f05162945974f461d729f11309015ab997cbf0acb35115::pnutrr {
    struct PNUTRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTRR>(arg0, 6, b"PNUTRR", b"Pnutrumpet", b"A squirrel that supports Trumpet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730979792985.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

