module 0xffdaf66a8d4888f206a25d07fb3ddb4bc7832078c11e42a352ba003c6d968347::sekoia {
    struct SEKOIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEKOIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SEKOIA>(arg0, 6, b"SEKOIA", b"Sekoia by Virtuals by SuiAI", b"Terminally on-chain VC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ow2_J66gu_400x400_3dd3719981.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEKOIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEKOIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

