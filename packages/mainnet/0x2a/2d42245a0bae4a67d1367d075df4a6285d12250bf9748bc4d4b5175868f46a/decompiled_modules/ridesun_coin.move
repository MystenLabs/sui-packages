module 0x2a2d42245a0bae4a67d1367d075df4a6285d12250bf9748bc4d4b5175868f46a::ridesun_coin {
    struct RIDESUN_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIDESUN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RIDESUN_COIN>>(0x2::coin::mint<RIDESUN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RIDESUN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIDESUN_COIN>(arg0, 9, b"RIDESUN_COIN", b"RIDESUN", b"learning for letsmove, power by ridesun", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIDESUN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIDESUN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

