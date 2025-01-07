module 0x7cfeeb33f5d66bed5a0746571d4d8b826637b6a859af7cd59c3ecfec2b97613f::naldo {
    struct NALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALDO>(arg0, 9, b"Naldo", b"SuiNaldo", b"Siuuuu or Suiiii?! Cristiano Ronaldo, Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NALDO>(&mut v2, 6900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALDO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

