module 0xbd674532f7350680e72f0ceb3d485a1fec0e2839e3a252ec85cebbc28f05881e::mint_mom_coin {
    struct MINT_MOM_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MINT_MOM_COIN>, arg1: 0x2::coin::Coin<MINT_MOM_COIN>) {
        0x2::coin::burn<MINT_MOM_COIN>(arg0, arg1);
    }

    fun init(arg0: MINT_MOM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINT_MOM_COIN>(arg0, 6, b"MINT_MOM_COIN", b"MINT_MOM_COIN", b"I love my mon, so mint mom coin...", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINT_MOM_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINT_MOM_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINT_MOM_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MINT_MOM_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

