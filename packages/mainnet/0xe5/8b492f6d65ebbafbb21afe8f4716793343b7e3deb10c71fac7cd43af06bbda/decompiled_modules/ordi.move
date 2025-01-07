module 0xe58b492f6d65ebbafbb21afe8f4716793343b7e3deb10c71fac7cd43af06bbda::ordi {
    struct ORDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORDI>(arg0, 9, b"ORDI", b"ORDI", b"ORDI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORDI>>(v1);
        0x2::coin::mint_and_transfer<ORDI>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ORDI>>(v2);
    }

    // decompiled from Move bytecode v6
}

