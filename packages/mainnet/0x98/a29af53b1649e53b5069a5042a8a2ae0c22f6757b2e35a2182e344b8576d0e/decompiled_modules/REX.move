module 0x98a29af53b1649e53b5069a5042a8a2ae0c22f6757b2e35a2182e344b8576d0e::REX {
    struct REX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REX>, arg1: 0x2::coin::Coin<REX>) {
        0x2::coin::burn<REX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REX>>(0x2::coin::mint<REX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 4, b"REX", b"REX", b"REX is the Core Engine of Autonomous Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/rex_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

