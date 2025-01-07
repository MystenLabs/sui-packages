module 0xde8707e80311ed50aea112ecacc299a005abbc3512159dddcc0ceda20d1dc0fb::cocilea_coin {
    struct COCILEA_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COCILEA_COIN>, arg1: 0x2::coin::Coin<COCILEA_COIN>) {
        0x2::coin::burn<COCILEA_COIN>(arg0, arg1);
    }

    fun init(arg0: COCILEA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCILEA_COIN>(arg0, 6, b"COCILEA COIN", b"COCILEA COIN", b"COCILEA COIN", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCILEA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCILEA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COCILEA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COCILEA_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

