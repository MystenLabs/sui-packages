module 0x5a601983e1c198916fb57a4cc1404837cc88ff0a0b5ff3e983a190c333059adb::drgnchan_coin {
    struct DRGNCHAN_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRGNCHAN_COIN>, arg1: 0x2::coin::Coin<DRGNCHAN_COIN>) {
        0x2::coin::burn<DRGNCHAN_COIN>(arg0, arg1);
    }

    fun init(arg0: DRGNCHAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRGNCHAN_COIN>(arg0, 9, b"DRGNCHAN", b"DRGNCHAN_COIN", b"drgnchan Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/40224023?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRGNCHAN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRGNCHAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRGNCHAN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRGNCHAN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

