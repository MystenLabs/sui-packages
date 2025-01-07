module 0xca91323681336a5b81bd8405ae740ebf25109d664ffdd1b5a25368e4ce53ce17::yxz252426_faucet {
    struct YXZ252426_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YXZ252426_FAUCET>, arg1: 0x2::coin::Coin<YXZ252426_FAUCET>) {
        0x2::coin::burn<YXZ252426_FAUCET>(arg0, arg1);
    }

    fun init(arg0: YXZ252426_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YXZ252426_FAUCET>(arg0, 9, b"YXZ", b"YXZ252426_FAUCET", b"YXZ252426 Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/76983474")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YXZ252426_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YXZ252426_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YXZ252426_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YXZ252426_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

