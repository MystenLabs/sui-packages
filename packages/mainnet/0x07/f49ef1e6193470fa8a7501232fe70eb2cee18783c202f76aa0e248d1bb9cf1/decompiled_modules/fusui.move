module 0x7f49ef1e6193470fa8a7501232fe70eb2cee18783c202f76aa0e248d1bb9cf1::fusui {
    struct FUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUSUI>(arg0, 6, b"FUSUI", b"FLUFFY SUI", b"THE $Fluffy content just keeps on Cooking!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FLUGY_483230bd83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

