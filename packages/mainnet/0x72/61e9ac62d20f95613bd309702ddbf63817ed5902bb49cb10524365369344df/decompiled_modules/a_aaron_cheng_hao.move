module 0x7261e9ac62d20f95613bd309702ddbf63817ed5902bb49cb10524365369344df::a_aaron_cheng_hao {
    struct A_AARON_CHENG_HAO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<A_AARON_CHENG_HAO>, arg1: 0x2::coin::Coin<A_AARON_CHENG_HAO>) {
        0x2::coin::burn<A_AARON_CHENG_HAO>(arg0, arg1);
    }

    fun init(arg0: A_AARON_CHENG_HAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_AARON_CHENG_HAO>(arg0, 6, b"A_AARON_CHENG_HAO", b"A_AARON_CHENG_HAO", b"I love A_AARON_CHENG_HAO. I love blockchains.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_AARON_CHENG_HAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_AARON_CHENG_HAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<A_AARON_CHENG_HAO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A_AARON_CHENG_HAO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

