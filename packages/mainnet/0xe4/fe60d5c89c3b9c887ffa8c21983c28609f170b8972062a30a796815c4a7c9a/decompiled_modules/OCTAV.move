module 0xe4fe60d5c89c3b9c887ffa8c21983c28609f170b8972062a30a796815c4a7c9a::OCTAV {
    struct OCTAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTAV>(arg0, 6, b"OCTAV", b"OCTAV", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTAV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTAV>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OCTAV>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OCTAV>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

