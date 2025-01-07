module 0x4687405f57e11367f5264b33597ffeca130b74ca01b95ff23357d2621faf65fc::viva {
    struct VIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 7;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<VIVA>(arg0, v0, b"VIVA", b"VIVATOKEN", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIVA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIVA>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<VIVA>>(0x2::coin::mint<VIVA>(&mut v4, 1000000000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

