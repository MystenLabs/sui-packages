module 0x5c3a506600b897784bb53e287f80e5f4fae65d6ac4e0936dcf0a8de829879669::fishsalter_coin {
    struct FISHSALTER_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FISHSALTER_COIN>, arg1: 0x2::coin::Coin<FISHSALTER_COIN>) {
        0x2::coin::burn<FISHSALTER_COIN>(arg0, arg1);
    }

    fun init(arg0: FISHSALTER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHSALTER_COIN>(arg0, 6, b"FISHSALTER_COIN", b"FISHSALTER_COIN", b"fishsalter coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHSALTER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHSALTER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FISHSALTER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FISHSALTER_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

