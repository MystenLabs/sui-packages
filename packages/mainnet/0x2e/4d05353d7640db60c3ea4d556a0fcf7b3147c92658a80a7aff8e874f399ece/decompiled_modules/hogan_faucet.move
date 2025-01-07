module 0x2e4d05353d7640db60c3ea4d556a0fcf7b3147c92658a80a7aff8e874f399ece::hogan_faucet {
    struct HOGAN_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOGAN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOGAN_FAUCET>(arg0, 8, b"0xHoGan Faucet", b"0xHoGan Faucet", b"this is 0xHoGan Faucet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://0xhogan.4everland.store/Logo.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOGAN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HOGAN_FAUCET>>(v0);
    }

    public entry fun mint_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<HOGAN_FAUCET>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HOGAN_FAUCET>>(0x2::coin::mint<HOGAN_FAUCET>(arg0, arg1, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HOGAN_FAUCET>>(0x2::coin::mint<HOGAN_FAUCET>(arg0, arg1, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

