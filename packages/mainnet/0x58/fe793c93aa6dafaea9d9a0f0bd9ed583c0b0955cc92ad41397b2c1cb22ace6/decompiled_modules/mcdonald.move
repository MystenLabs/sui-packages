module 0x58fe793c93aa6dafaea9d9a0f0bd9ed583c0b0955cc92ad41397b2c1cb22ace6::mcdonald {
    struct MCDONALD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MCDONALD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MCDONALD>>(0x2::coin::mint<MCDONALD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MCDONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCDONALD>(arg0, 6, b"MCDONALD", b"Mc Donald", b"Hello and welcome to McDonald, may I take your order please? McMAGA.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCDONALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCDONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

