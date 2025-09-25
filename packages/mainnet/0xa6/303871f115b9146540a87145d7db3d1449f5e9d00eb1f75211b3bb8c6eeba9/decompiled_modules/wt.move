module 0xa6303871f115b9146540a87145d7db3d1449f5e9d00eb1f75211b3bb8c6eeba9::wt {
    struct WT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WT>, arg1: 0x2::coin::Coin<WT>) {
        0x2::coin::burn<WT>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<WT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WT> {
        0x2::coin::mint<WT>(arg0, arg1, arg2)
    }

    fun init(arg0: WT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WT>(arg0, 6, b"WT", b"WTT", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758725592996YwWG.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WT>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<WT>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WT> {
        assert!(0x2::coin::total_supply<WT>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<WT>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

