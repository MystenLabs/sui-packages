module 0xf6b986c67c705eae9ddbd0b8ee73c61458a94341f46d76b988df0a5da62e8390::zzzx {
    struct ZZZX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZZZX>, arg1: 0x2::coin::Coin<ZZZX>) {
        0x2::coin::burn<ZZZX>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZZZX>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZZZX> {
        0x2::coin::mint<ZZZX>(arg0, arg1, arg2)
    }

    fun init(arg0: ZZZX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZX>(arg0, 6, b"ZZZX", b"cccz", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758871776536h9cr.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZZX>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<ZZZX>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZZZX> {
        assert!(0x2::coin::total_supply<ZZZX>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<ZZZX>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

