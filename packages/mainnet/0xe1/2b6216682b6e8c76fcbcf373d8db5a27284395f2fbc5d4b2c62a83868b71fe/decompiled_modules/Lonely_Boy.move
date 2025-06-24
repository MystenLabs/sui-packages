module 0xe12b6216682b6e8c76fcbcf373d8db5a27284395f2fbc5d4b2c62a83868b71fe::Lonely_Boy {
    struct LONELY_BOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONELY_BOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONELY_BOY>(arg0, 9, b"LBOY", b"Lonely Boy", b"hes lonely", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/96114b5d-e997-4c71-97e6-621167a68edb.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONELY_BOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONELY_BOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

