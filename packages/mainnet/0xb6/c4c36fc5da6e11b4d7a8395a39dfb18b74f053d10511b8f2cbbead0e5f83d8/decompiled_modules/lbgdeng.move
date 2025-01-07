module 0xb6c4c36fc5da6e11b4d7a8395a39dfb18b74f053d10511b8f2cbbead0e5f83d8::lbgdeng {
    struct LBGDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBGDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBGDENG>(arg0, 6, b"LBGDENG", b"Transgendeng", b"First LGBT moo deng on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_5eb9aa82a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBGDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LBGDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

