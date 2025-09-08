module 0x216e70ed2d68d1cf81e13f5c5df799730c1a8a00101174d1aee698e962b809c8::SUIDOG {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDOG>, arg1: 0x2::coin::Coin<SUIDOG>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SUIDOG>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDOG>>(0x2::coin::mint<SUIDOG>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SUIDOG>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIDOG>>(arg0);
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 9, b"SUIDOG", b"SUI Dividend Dog", b"The first dividend dog on the SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68be39825fb0e1.60412131.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

