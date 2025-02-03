module 0x88bd5b9175a382c1f17a2e41629bc5c58419955752a691811d508c4166f0e585::token7 {
    struct TOKEN7 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN7>, arg1: 0x2::coin::Coin<TOKEN7>) {
        0x2::coin::burn<TOKEN7>(arg0, arg1);
    }

    fun init(arg0: TOKEN7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN7>(arg0, 9, b"rewardclub.online", b"rewardclub.online", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN7>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN7>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN7>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

