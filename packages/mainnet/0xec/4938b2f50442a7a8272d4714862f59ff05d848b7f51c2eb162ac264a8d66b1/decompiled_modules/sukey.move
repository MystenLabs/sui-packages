module 0xec4938b2f50442a7a8272d4714862f59ff05d848b7f51c2eb162ac264a8d66b1::sukey {
    struct SUKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKEY>(arg0, 6, b"Sukey", b"Sui Monkey", b"Keep hold $Sukey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730995350438.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

