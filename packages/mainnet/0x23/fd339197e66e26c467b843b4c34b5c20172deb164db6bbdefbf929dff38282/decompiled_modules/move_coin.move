module 0x23fd339197e66e26c467b843b4c34b5c20172deb164db6bbdefbf929dff38282::move_coin {
    struct MOVE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOVE_COIN>, arg1: 0x2::coin::Coin<MOVE_COIN>) {
        0x2::coin::burn<MOVE_COIN>(arg0, arg1);
    }

    fun init(arg0: MOVE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE_COIN>(arg0, 10, b"Funnyyanne", b"Funnyyanne COIN", b"Anne's Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<MOVE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOVE_COIN>>(0x2::coin::mint<MOVE_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

