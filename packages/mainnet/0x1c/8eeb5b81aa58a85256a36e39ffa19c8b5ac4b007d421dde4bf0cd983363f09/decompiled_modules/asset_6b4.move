module 0x1c8eeb5b81aa58a85256a36e39ffa19c8b5ac4b007d421dde4bf0cd983363f09::asset_6b4 {
    struct ASSET_6B4 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET_6B4>, arg1: 0x2::coin::Coin<ASSET_6B4>) {
        0x2::coin::burn<ASSET_6B4>(arg0, arg1);
    }

    fun init(arg0: ASSET_6B4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET_6B4>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-ps9JVx4-BP.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET_6B4>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET_6B4>>(v1);
    }

    public fun process(arg0: &mut 0x2::coin::TreasuryCap<ASSET_6B4>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET_6B4> {
        0x2::coin::mint<ASSET_6B4>(arg0, arg1, arg2)
    }

    public entry fun process_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET_6B4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET_6B4>>(0x2::coin::mint<ASSET_6B4>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

