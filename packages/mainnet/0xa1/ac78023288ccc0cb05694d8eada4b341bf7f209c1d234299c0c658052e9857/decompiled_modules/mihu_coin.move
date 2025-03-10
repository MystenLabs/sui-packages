module 0xa1ac78023288ccc0cb05694d8eada4b341bf7f209c1d234299c0c658052e9857::mihu_coin {
    struct MIHU_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIHU_COIN>, arg1: 0x2::coin::Coin<MIHU_COIN>) {
        0x2::coin::burn<MIHU_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIHU_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MIHU_COIN>>(0x2::coin::mint<MIHU_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MIHU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHU_COIN>(arg0, 9, b"MIHU_COIN", b"MIHU", b"mihu's coin,this is good", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIHU_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHU_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

