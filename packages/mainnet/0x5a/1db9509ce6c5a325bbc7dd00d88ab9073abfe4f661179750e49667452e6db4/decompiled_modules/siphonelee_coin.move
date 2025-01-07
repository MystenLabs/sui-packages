module 0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin {
    struct SIPHONELEE_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIPHONELEE_COIN>, arg1: 0x2::coin::Coin<SIPHONELEE_COIN>) {
        0x2::coin::burn<SIPHONELEE_COIN>(arg0, arg1);
    }

    fun init(arg0: SIPHONELEE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPHONELEE_COIN>(arg0, 6, b" SIPHONELEE-COIN", b"SIPHONE", b"the coin of siphonelee", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIPHONELEE_COIN>>(v1);
        0x2::coin::mint_and_transfer<SIPHONELEE_COIN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPHONELEE_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIPHONELEE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIPHONELEE_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

