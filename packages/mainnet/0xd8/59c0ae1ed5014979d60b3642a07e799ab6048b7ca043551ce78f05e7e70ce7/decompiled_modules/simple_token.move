module 0xd859c0ae1ed5014979d60b3642a07e799ab6048b7ca043551ce78f05e7e70ce7::simple_token {
    struct SIMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIMPLE_TOKEN>, arg1: 0x2::coin::Coin<SIMPLE_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x1234567890abcdef, 1);
        0x2::coin::burn<SIMPLE_TOKEN>(arg0, arg1);
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"BRO", b"Crypto BRO's On SUI", b"BRO, Lets Freekin GO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-api-mainnet.bluemove.net/uploads/bro_on_sui_png_circle_white512x512_240538a167.WEBP")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SIMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SIMPLE_TOKEN>(arg0, arg1);
        0x2::coin::mint_and_transfer<SIMPLE_TOKEN>(&mut v0, 100000000, @0xa, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

