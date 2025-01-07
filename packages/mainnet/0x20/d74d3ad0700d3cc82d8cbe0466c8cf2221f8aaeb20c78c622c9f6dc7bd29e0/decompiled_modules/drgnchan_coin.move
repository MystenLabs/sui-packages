module 0x20d74d3ad0700d3cc82d8cbe0466c8cf2221f8aaeb20c78c622c9f6dc7bd29e0::drgnchan_coin {
    struct DRGNCHAN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRGNCHAN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DRGNCHAN_COIN>>(0x2::coin::mint<DRGNCHAN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DRGNCHAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRGNCHAN_COIN>(arg0, 6, b"DRGNCHAN_COIN", b"drgnchan_COIN", b"drgnchan coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/40224023?v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRGNCHAN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRGNCHAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

