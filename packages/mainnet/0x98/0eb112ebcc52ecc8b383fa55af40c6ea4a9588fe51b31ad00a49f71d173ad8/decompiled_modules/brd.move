module 0x980eb112ebcc52ecc8b383fa55af40c6ea4a9588fe51b31ad00a49f71d173ad8::brd {
    struct BRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRD>(arg0, 6, b"BRD", b"BRAD", b"''BRAD'' is a lifestyle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731507663218.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

