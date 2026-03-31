module 0x81bc05ab9fecb6e11e5ff78b3e7899e35904e1a9a2c801e7653f05549ac7e058::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGA>(arg0, 6, b"MEGA", b"Mega SUI", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEGA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEGA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEGA>>(v2);
    }

    // decompiled from Move bytecode v6
}

