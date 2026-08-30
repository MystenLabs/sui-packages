module 0x6e433d874a357cc7b96729a2bb005575548f09634ce27efd2595e47777028d0::ug14o2j {
    struct UG14O2J has drop {
        dummy_field: bool,
    }

    fun init(arg0: UG14O2J, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UG14O2J>(arg0, 0, b"UG14O2J", b"Sui Blue Gift User G14O2J", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UG14O2J>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UG14O2J>>(0x2::coin::mint<UG14O2J>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UG14O2J>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

