module 0xf419d807e4d8984e16ea8f06d883450b595d3dae109e06a6d829b2b46089b09b::ty1 {
    struct TY1 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TY1>, arg1: 0x2::coin::Coin<TY1>) {
        0x2::coin::burn<TY1>(arg0, arg1);
    }

    fun init(arg0: TY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TY1>(arg0, 6, b"TY1", b"TY1", b"test coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TY1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TY1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TY1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TY1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

