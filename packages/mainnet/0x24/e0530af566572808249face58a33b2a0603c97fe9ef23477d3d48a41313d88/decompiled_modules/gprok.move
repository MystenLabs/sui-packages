module 0x24e0530af566572808249face58a33b2a0603c97fe9ef23477d3d48a41313d88::gprok {
    struct GPROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPROK>(arg0, 6, b"GPROK", b"Gprok Invest", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GPROK>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPROK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GPROK>>(v2);
    }

    // decompiled from Move bytecode v6
}

