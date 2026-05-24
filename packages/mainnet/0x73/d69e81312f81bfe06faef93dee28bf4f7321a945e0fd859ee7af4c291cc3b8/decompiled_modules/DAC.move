module 0x73d69e81312f81bfe06faef93dee28bf4f7321a945e0fd859ee7af4c291cc3b8::DAC {
    struct DAC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DAC>, arg1: 0x2::coin::Coin<DAC>) {
        0x2::coin::burn<DAC>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DAC>>(0x2::coin::mint<DAC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAC>(arg0, 4, b"DAC", b"DAC", b"DAC is the Core Engine of Autonomous Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/dac_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

