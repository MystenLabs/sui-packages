module 0x44d1689fef3c6c1d00433da0acb0d48b20a0110eb5f7439a72b93c026ad5d7eb::londonv2 {
    struct LONDONV2 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LONDONV2>, arg1: 0x2::coin::Coin<LONDONV2>) {
        0x2::coin::burn<LONDONV2>(arg0, arg1);
    }

    fun init(arg0: LONDONV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONDONV2>(arg0, 6, b"LONDONV2", b"londonv2", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONDONV2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONDONV2>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LONDONV2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LONDONV2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

