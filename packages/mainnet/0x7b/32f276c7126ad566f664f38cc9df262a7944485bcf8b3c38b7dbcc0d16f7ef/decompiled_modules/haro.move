module 0x7b32f276c7126ad566f664f38cc9df262a7944485bcf8b3c38b7dbcc0d16f7ef::haro {
    struct HARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARO>(arg0, 6, b"HARO", b"BALD", b"CUSTOMER SERVICE ORANGE LA DEFENSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949169044.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

