module 0x75dbe6fdfdd59010d41f7ba26ec79410e3e945c79688dace8d9547a529389de1::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PAN>, arg1: 0x2::coin::Coin<PAN>) {
        0x2::coin::burn<PAN>(arg0, arg1);
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 9, b"PAN", b"PAN", b"Pandorian token (TBD)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pandorafi.xyz")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

