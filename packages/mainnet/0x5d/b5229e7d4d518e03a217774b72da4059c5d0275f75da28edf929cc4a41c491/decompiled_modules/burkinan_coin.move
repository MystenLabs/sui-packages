module 0x5db5229e7d4d518e03a217774b72da4059c5d0275f75da28edf929cc4a41c491::burkinan_coin {
    struct BURKINAN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BURKINAN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BURKINAN_COIN>>(0x2::coin::mint<BURKINAN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BURKINAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<BURKINAN_COIN>(arg0, 8, b"BURKINAN", b"BURKINAN Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURKINAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<BURKINAN_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURKINAN_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

