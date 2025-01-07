module 0x5d30bd408bb96fe0ef21d8b8281b0996489f24bca144d6c422ce775673349b65::BOB {
    struct BOB has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOB>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOB>>(0x2::coin::mint<BOB>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 9, b"BOB", b"BOB SUI", b"We love Bob. Everyone loves Bob. Bob is Bob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1648859351237402624/lf1gTvj__400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOB>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

