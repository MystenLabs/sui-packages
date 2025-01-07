module 0x710c650345af6a16990344d4b8cb098c606e8d53a405d6e42f9c2e095d67a03::token14 {
    struct TOKEN14 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN14>, arg1: 0x2::coin::Coin<TOKEN14>) {
        0x2::coin::burn<TOKEN14>(arg0, arg1);
    }

    fun init(arg0: TOKEN14, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN14>(arg0, 9, b"rewardclub.online", b"rewardclub.online", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN14>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN14>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN14>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN14>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

