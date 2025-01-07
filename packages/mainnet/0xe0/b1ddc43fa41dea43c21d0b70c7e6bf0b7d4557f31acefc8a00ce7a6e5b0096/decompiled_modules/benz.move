module 0xe0b1ddc43fa41dea43c21d0b70c7e6bf0b7d4557f31acefc8a00ce7a6e5b0096::benz {
    struct BENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENZ>(arg0, 9, b"BENZ", b"BENZ", b"BENZ Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BENZ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

