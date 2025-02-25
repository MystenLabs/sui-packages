module 0x51b0a0f5ac4219241f6319a1ca805c5b79f8ebe394b7a4379a04e83da3b4c459::kfc {
    struct KFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFC>(arg0, 6, b"KFC", b"KFC", b"Happy Monday", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KFC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KFC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

