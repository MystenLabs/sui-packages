module 0x1dd12a25f886d44ae4cb76327ed7498f6c709aa224c2e9effe7ee976453e2470::swee {
    struct SWEE has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 6, b"SMPL", b"Simple Token", b"Token that showcases denylist", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWEE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SWEE>>(0x2::coin::mint<SWEE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SWEE>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

