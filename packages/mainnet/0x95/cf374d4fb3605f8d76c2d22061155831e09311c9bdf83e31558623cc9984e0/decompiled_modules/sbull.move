module 0x95cf374d4fb3605f8d76c2d22061155831e09311c9bdf83e31558623cc9984e0::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 9, b"SBULL", b"Bull On Sui", b"SBULL On Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x32b016fcfe724daf045da331cb12eb0d9fa3c1e20e2c48f8dee04cc42ef208c4::sbull::sbull.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBULL>(&mut v2, 650000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

