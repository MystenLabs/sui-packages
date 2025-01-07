module 0xdd3909c1c8ac10cb438d81438c9698c65f9973b4a07e721bd9b027998583fbce::dave {
    struct DAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVE>(arg0, 9, b"DAVE", b"Dave", b"hi, my name is Dave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AyC3vxC3JWX5iK7HjzLm3iKRVPQQR163JifcRom9pump.png?size=xl&key=c1f108")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAVE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

