module 0xee513f6ff11dcf527554877d8e55d61cce5e1e13a7ce947fea3b1c53ba47b096::sunita {
    struct SUNITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNITA>(arg0, 9, b"SUNITA", b"SUNITA", b" Prettiest Dog On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/isGpHkm.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNITA>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUNITA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNITA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

