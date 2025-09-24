module 0x1ffa5876f3519b22221dad023218238b34ad7d2913f68b87c6a24cdc9268af71::pinguofficial {
    struct PINGUOFFICIAL has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PINGUOFFICIAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PINGUOFFICIAL>>(0x2::coin::mint<PINGUOFFICIAL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PINGUOFFICIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGUOFFICIAL>(arg0, 9, b"PINGU OFFICIAL", b"PINGU", b"The real Pingu, NOOT NOOT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758702804/sui_tokens/eir8tekp2v4mq2na5q69.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PINGUOFFICIAL>>(0x2::coin::mint<PINGUOFFICIAL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGUOFFICIAL>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PINGUOFFICIAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

