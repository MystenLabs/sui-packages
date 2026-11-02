module 0xbd0df02b6bc5809fd9c915f940a738cd736b362cd2dd1b6812f83c5de4218e77::recovery_token {
    struct RECOVERY_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RECOVERY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RECOVERY_TOKEN>(arg0, 6, b"RCVR", b"Recovery Token", b"Custom base asset for the DeepBook recovery pool", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RECOVERY_TOKEN>>(0x2::coin::mint<RECOVERY_TOKEN>(&mut v2, 10000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RECOVERY_TOKEN>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RECOVERY_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v7
}

