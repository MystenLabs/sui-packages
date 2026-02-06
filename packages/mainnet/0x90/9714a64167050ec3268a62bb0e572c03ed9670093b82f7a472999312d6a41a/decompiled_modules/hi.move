module 0x909714a64167050ec3268a62bb0e572c03ed9670093b82f7a472999312d6a41a::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HI>, arg1: 0x2::coin::Coin<HI>) {
        0x2::coin::burn<HI>(arg0, arg1);
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HI>(arg0, 6, b"HIHI", b"hi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

