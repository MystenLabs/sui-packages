module 0xda3238f8f7fe4f095aeb9a54e8b16760bf46fde6857bfaa77842491559b18a96::Ox4e33token {
    struct OX4E33TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<OX4E33TOKEN>, arg1: 0x2::coin::Coin<OX4E33TOKEN>) {
        0x2::coin::burn<OX4E33TOKEN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OX4E33TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OX4E33TOKEN>>(0x2::coin::mint<OX4E33TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: OX4E33TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OX4E33TOKEN>(arg0, 18, b"0x4E33Token", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OX4E33TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OX4E33TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

