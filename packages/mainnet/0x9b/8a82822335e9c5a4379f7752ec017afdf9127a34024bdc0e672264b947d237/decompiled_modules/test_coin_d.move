module 0x9b8a82822335e9c5a4379f7752ec017afdf9127a34024bdc0e672264b947d237::test_coin_d {
    struct TEST_COIN_D has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN_D>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_COIN_D>>(0x2::coin::mint<TEST_COIN_D>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TEST_COIN_D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_COIN_D>(arg0, 9, b"TMEMEFI", b"TMemeFi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.memefi.club/landing/logo/memefi.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_COIN_D>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_COIN_D>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

