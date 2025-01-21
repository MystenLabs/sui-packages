module 0x1a9e3f1d94f33200a69cda23a8169e1f485d0cd1a54718ac1432e679de909651::daox {
    struct DAOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOX>(arg0, 9, b"DAOX", b"DAOX", b"A New Era of Onchain AI Agents @SuiNetwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://virtualdaos.ai/images/daox_logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DAOX>>(0x2::coin::mint<DAOX>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DAOX>>(v2);
    }

    // decompiled from Move bytecode v6
}

