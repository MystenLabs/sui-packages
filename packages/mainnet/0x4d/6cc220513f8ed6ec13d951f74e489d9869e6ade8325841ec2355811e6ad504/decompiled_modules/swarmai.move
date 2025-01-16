module 0x4d6cc220513f8ed6ec13d951f74e489d9869e6ade8325841ec2355811e6ad504::swarmai {
    struct SWARMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARMAI>(arg0, 6, b"SWARMAI", b"Swarm Network on Sui", x"57656c636f6d6520746f20746865207472757468207465726d696e616c2e2041726520796f7520726561647920746f20707572737565207468652074727574683f0a0a537761726d204e6574776f726b206973207472757468207468726f756768204149206f6e205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736996765327.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWARMAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARMAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

