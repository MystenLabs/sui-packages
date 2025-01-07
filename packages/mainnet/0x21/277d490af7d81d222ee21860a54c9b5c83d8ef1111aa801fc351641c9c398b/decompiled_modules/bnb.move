module 0x21277d490af7d81d222ee21860a54c9b5c83d8ef1111aa801fc351641c9c398b::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BNB>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BNB>>(0x2::coin::mint<BNB>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 9, b"TCOIN", b"Token FOR TCOIN", b"Coin TCOIN", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BNB>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNB>>(v1);
    }

    public entry fun mint_to(arg0: &mut 0x2::coin::TreasuryCap<BNB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BNB>>(0x2::coin::mint<BNB>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

