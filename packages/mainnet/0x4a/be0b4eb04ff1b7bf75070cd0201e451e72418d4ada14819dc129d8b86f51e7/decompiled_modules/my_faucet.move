module 0x4abe0b4eb04ff1b7bf75070cd0201e451e72418d4ada14819dc129d8b86f51e7::my_faucet {
    struct MY_FAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_FAUCET>>(0x2::coin::mint<MY_FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MY_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_FAUCET>(arg0, 6, b"Ni1L", b"Ni1L", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MY_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

