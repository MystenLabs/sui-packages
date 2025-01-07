module 0x2e4d05353d7640db60c3ea4d556a0fcf7b3147c92658a80a7aff8e874f399ece::hogan {
    struct HOGAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOGAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOGAN>(arg0, 8, b"0xHoGan", b"0xHoGan", b"this is 0xHoGan Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://0xhogan.4everland.store/Logo.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOGAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOGAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_my_coin(arg0: &mut 0x2::coin::TreasuryCap<HOGAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HOGAN>>(0x2::coin::mint<HOGAN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

