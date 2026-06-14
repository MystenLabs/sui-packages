module 0xc4e43eb94eb41ecb1015561ff4654fd254a1ecf8a01612a369ed39e6ae21cbc2::flip_token {
    struct FLIP_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLIP_TOKEN>, arg1: 0x2::coin::Coin<FLIP_TOKEN>) {
        0x2::coin::burn<FLIP_TOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLIP_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLIP_TOKEN>>(0x2::coin::mint<FLIP_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLIP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP_TOKEN>(arg0, 0, b"FLIP", b"FLIP", b"Earn FLIP by playing Coin Flip. Convert to USDT on DEX.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-flip.xyz/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIP_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

