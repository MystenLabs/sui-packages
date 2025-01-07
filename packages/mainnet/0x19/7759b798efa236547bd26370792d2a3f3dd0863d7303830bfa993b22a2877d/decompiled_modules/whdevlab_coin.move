module 0x197759b798efa236547bd26370792d2a3f3dd0863d7303830bfa993b22a2877d::whdevlab_coin {
    struct WHDEVLAB_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WHDEVLAB_COIN>, arg1: 0x2::coin::Coin<WHDEVLAB_COIN>) {
        0x2::coin::burn<WHDEVLAB_COIN>(arg0, arg1);
    }

    fun init(arg0: WHDEVLAB_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHDEVLAB_COIN>(arg0, 9, b"WHDEVLAB_COIN", b"WHDEVLAB_COIN", b"coin create by WHDEVLAB", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHDEVLAB_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHDEVLAB_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHDEVLAB_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WHDEVLAB_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

