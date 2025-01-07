module 0x5a3d2f5e1a117e81b425fb900abc90a28eda41b0e937ab259583114d32af94c5::suisenji {
    struct SUISENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISENJI>(arg0, 9, b"SUISENJI", b"Suisenji", b"Meet Basenji, the oldest dog breed in history, born to live on the Sui Chain.  The dog of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xbc45647ea894030a4e9801ec03479739fa2485f0.png?size=xl&key=951e75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISENJI>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISENJI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

