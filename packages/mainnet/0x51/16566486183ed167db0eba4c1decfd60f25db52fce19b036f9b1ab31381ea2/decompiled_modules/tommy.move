module 0x5116566486183ed167db0eba4c1decfd60f25db52fce19b036f9b1ab31381ea2::tommy {
    struct TOMMY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOMMY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOMMY>>(0x2::coin::mint<TOMMY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TOMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMMY>(arg0, 6, b"TOMMY", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

