module 0x855641282e5b21a2c72e93493de1c975d17dee5ceedadc274d0bc19db15a1201::exa_coin {
    struct EXA_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<EXA_COIN>, arg1: 0x2::coin::Coin<EXA_COIN>) {
        0x2::coin::burn<EXA_COIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<EXA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EXA_COIN>>(0x2::coin::mint<EXA_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: EXA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXA_COIN>(arg0, 6, b"EXA", b"EXA", x"e382b3e382a4e383b3e4bd9ce68890e381aee38387e383a2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

