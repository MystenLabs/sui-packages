module 0x3ba995b6f4ef4f90147b629cdd5e490ca41cefeccb6523c919808cbe803d8229::catata {
    struct CATATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATATA>(arg0, 6, b"Catata", b"Catatafish", b"Legendary Catatafish here to bless SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_012041_504ec95f1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

