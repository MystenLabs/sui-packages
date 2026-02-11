module 0x178e9b34e7b77cc948af916289745ca8446b35f6736b123c172dbf964251516f::milextasy {
    struct MILEXTASY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MILEXTASY>, arg1: 0x2::coin::Coin<MILEXTASY>) {
        0x2::coin::burn<MILEXTASY>(arg0, arg1);
    }

    fun init(arg0: MILEXTASY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILEXTASY>(arg0, 6, b"MLXY", b"Milextasy", b"Milextasy is a cyberpunk fever dream w/ bleached hair & mismatched eyes that pierce reality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fy5a0oQ.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILEXTASY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILEXTASY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MILEXTASY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MILEXTASY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

