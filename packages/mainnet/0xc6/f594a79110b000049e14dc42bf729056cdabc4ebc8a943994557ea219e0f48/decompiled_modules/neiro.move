module 0xc6f594a79110b000049e14dc42bf729056cdabc4ebc8a943994557ea219e0f48::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 9, b"NEIRO", b"Sui Neiro", b"0xa9ef87ac5f3ea227a9ec3e309067565a8797a3a617022078db9dbb7768febfca::neiro::NEIRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xa9ef87ac5f3ea227a9ec3e309067565a8797a3a617022078db9dbb7768febfca::neiro::neiro.png?size=xl&key=97a390")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEIRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

