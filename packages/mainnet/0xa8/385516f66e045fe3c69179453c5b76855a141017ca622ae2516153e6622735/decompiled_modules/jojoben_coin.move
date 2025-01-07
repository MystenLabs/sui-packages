module 0xa8385516f66e045fe3c69179453c5b76855a141017ca622ae2516153e6622735::jojoben_coin {
    struct JOJOBEN_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOJOBEN_COIN>, arg1: 0x2::coin::Coin<JOJOBEN_COIN>) {
        0x2::coin::burn<JOJOBEN_COIN>(arg0, arg1);
    }

    fun init(arg0: JOJOBEN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOJOBEN_COIN>(arg0, 9, b"JOJOBEN_COIN", b"jojoben", b"jojoben coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/173065194?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOJOBEN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOJOBEN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOJOBEN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOJOBEN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

