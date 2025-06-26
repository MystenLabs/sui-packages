module 0x4b56ce4dee956ed97f600a59e0751958632b95b16866cbad9449468becd9a49c::asdfsd {
    struct ASDFSD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASDFSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASDFSD>>(0x2::coin::mint<ASDFSD>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: ASDFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDFSD>(arg0, 9, b"ASDFSD", b"sdfasdf sdf", b"sadfsdfsdf dffsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plz.money/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ASDFSD>>(0x2::coin::mint<ASDFSD>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDFSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDFSD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

