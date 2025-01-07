module 0x4853f1ff1fceed9fc02182ab99cba55dfd5d264f4520eb449288efd52ee94e32::cry {
    struct CRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRY>(arg0, 6, b"CRY", b"CRYSEA", b"SAME STORY LIKE ALWAYS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985669129.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

