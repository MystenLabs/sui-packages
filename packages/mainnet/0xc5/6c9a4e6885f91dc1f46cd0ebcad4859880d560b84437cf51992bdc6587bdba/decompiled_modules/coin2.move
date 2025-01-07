module 0xc56c9a4e6885f91dc1f46cd0ebcad4859880d560b84437cf51992bdc6587bdba::coin2 {
    struct COIN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN2>(arg0, 8, b"Coin2", b"C2", b"Coin2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

