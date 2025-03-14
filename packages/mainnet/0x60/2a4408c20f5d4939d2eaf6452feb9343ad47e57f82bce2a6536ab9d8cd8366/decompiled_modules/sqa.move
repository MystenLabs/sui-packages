module 0x602a4408c20f5d4939d2eaf6452feb9343ad47e57f82bce2a6536ab9d8cd8366::sqa {
    struct SQA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SQA>(arg0) + arg1 <= 1290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SQA>>(0x2::coin::mint<SQA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SQA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQA>(arg0, 6, b"SQA", b"SQA", b"SQA Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SQA>>(0x2::coin::mint<SQA>(&mut v2, 1290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

