module 0x4ff42986b98a10eb3b8587f0286787040a2cbb59bb9e95c65d0b2d21a4528092::USDT {
    struct USDT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: 0x2::coin::Coin<USDT>) {
        0x2::coin::burn<USDT>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDT ", b"USDT ", b"USDT TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/usdt.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

