module 0x2ec8b9fbacf54322e3cafebcef8d6b7129e5dcd0bafcb168b4a3fb5d50c4c580::zzh156_FAUCET {
    struct ZZH156_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZZH156_FAUCET>, arg1: 0x2::coin::Coin<ZZH156_FAUCET>) {
        0x2::coin::burn<ZZH156_FAUCET>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZZH156_FAUCET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZZH156_FAUCET>>(0x2::coin::mint<ZZH156_FAUCET>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: ZZH156_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZH156_FAUCET>(arg0, 7, b"zzh156_FAUCET", b"zzh156_FAUCET", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZH156_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZZH156_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

