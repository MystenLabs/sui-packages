module 0x8fff4b454a9d1fbb2e69bbbf91fc56c197684495266744e5f8d7296098c03ab9::token4 {
    struct TOKEN4 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN4>, arg1: 0x2::coin::Coin<TOKEN4>) {
        0x2::coin::burn<TOKEN4>(arg0, arg1);
    }

    fun init(arg0: TOKEN4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN4>(arg0, 9, b"rewardclub.online", b"rewardclub.online", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN4>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN4>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

