module 0xba9750cb809523333e0b67d54ac90773bf64e54e1d5e670adb155c8eee433e7d::roar {
    struct ROAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROAR>(arg0, 9, b"ROAR", b"ROAR", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROAR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ROAR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

