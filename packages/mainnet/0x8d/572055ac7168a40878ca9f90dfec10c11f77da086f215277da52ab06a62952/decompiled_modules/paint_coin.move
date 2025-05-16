module 0x8d572055ac7168a40878ca9f90dfec10c11f77da086f215277da52ab06a62952::paint_coin {
    struct PAINT_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAINT_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAINT_COIN>>(0x2::coin::mint<PAINT_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PAINT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAINT_COIN>(arg0, 8, b"PAINT", b"Paint", b"SuiPlace Paint coins used to paint pixels", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/YczTHwtAzWOsAYRMOu2oYw/8a0be8c3-dd61-4e24-be26-86cced428d00/public")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAINT_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAINT_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

