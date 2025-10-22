module 0xa93fdee573f7aa87695277c0b619be6441da37426b701b4d967a2173765f12d7::suiweep {
    struct SUIWEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEEP>(arg0, 9, b"SUIWEEP", b"SUIWEEP", b"SUIEEEEEP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761151043/sui_tokens/hmusddlywxnvfn2nopnb.avif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIWEEP>>(0x2::coin::mint<SUIWEEP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIWEEP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWEEP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

