module 0x6c0f26320febdd2c13a8b2bdcde8210ec430c801d9e16f4252d6c372ba2e8ad6::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"SUIA CAT by SuiAI", b"The dominant cat in SUI ecosystem. MEOW meow to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SCAT_0f2491d869.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

