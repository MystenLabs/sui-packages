module 0x40b6bdb8d68ee0a0ed660e8ba9a7cd20651b5dd1c79ec41384a2ea503138d752::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: 0x2::coin::Coin<MY_COIN>) {
        0x2::coin::burn<MY_COIN>(arg0, arg1);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 2, b"MY_COIN", b"syc", b"deploy by sycskye28", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

