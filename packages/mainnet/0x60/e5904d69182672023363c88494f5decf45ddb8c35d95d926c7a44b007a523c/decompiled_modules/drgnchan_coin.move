module 0x60e5904d69182672023363c88494f5decf45ddb8c35d95d926c7a44b007a523c::drgnchan_coin {
    struct DRGNCHAN_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRGNCHAN_COIN>, arg1: 0x2::coin::Coin<DRGNCHAN_COIN>) {
        0x2::coin::burn<DRGNCHAN_COIN>(arg0, arg1);
    }

    fun init(arg0: DRGNCHAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRGNCHAN_COIN>(arg0, 9, b"DRGNCHAN", b"DRGNCHAN", b"drgnchan Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/40224023?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRGNCHAN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRGNCHAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRGNCHAN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRGNCHAN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

