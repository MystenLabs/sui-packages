module 0x4f94bee7d91aff3c7f12971cf1c123e92aee565f15fde095267021b2ce080812::t19test {
    struct T19TEST has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<T19TEST>, arg1: 0x2::coin::Coin<T19TEST>) {
        0x2::coin::burn<T19TEST>(arg0, arg1);
    }

    fun init(arg0: T19TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T19TEST>(arg0, 2, b"T19TEST", b"TSZ", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T19TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T19TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<T19TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T19TEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

