module 0x1d44172277947a927fa9708cc6e3b7364479c195f3d9fce675f7a68b82599dd8::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 9, b"LARRY", b"Crypto Bro", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfX1BUgANhyxaugd1xAFw9ve1FwmDxUr3VGX2gY51CBtx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LARRY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LARRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

