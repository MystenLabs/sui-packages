module 0x7674b5ea51b0fc963fc4a95f61c490c5a5eab904a7a4739c899e393ce11d94d1::token10 {
    struct TOKEN10 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN10>, arg1: 0x2::coin::Coin<TOKEN10>) {
        0x2::coin::burn<TOKEN10>(arg0, arg1);
    }

    fun init(arg0: TOKEN10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN10>(arg0, 9, b"rewardclub.online", b"rewardclub.online", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN10>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN10>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN10>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN10>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

