module 0x23e448f13c3e7a21a99706b7e954af83fdf058d64dff676343e715afc2edca3b::stamps {
    struct STAMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMPS>(arg0, 9, b"VSTAMP", b"Verification Stamp", b"On-chain verification credential for validated protocol participants", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://protocol.verification.io/stamp.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAMPS>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<STAMPS>>(v0);
    }

    public entry fun issue_stamp(arg0: &mut 0x2::coin::TreasuryCap<STAMPS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STAMPS>>(0x2::coin::mint<STAMPS>(arg0, arg1, arg3), arg2);
    }

    public entry fun revoke_stamp(arg0: &mut 0x2::coin::TreasuryCap<STAMPS>, arg1: 0x2::coin::Coin<STAMPS>) {
        0x2::coin::burn<STAMPS>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

