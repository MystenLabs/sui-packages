module 0xc05dbcf39a80d5f2cc55e78c26d75d0b9876e7f1f783597feb6b1c11415f5f07::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BTC>>(0x2::coin::mint<BTC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 8, b"BTC", b"Bitcoin", b"Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/images/tokens/btc.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

