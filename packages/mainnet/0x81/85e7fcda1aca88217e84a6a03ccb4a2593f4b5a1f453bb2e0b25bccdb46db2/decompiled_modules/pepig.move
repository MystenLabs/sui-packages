module 0x8185e7fcda1aca88217e84a6a03ccb4a2593f4b5a1f453bb2e0b25bccdb46db2::pepig {
    struct PEPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPIG>(arg0, 9, b"PEPIG", b"Sui Pepig", b"Hi, I'm $PEPIG - degen by night, also degen and gambler by day. We did it once, we'll do it again...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmZ3jUBXN6g5mvuzBewcePWx4XRwPhAyFY1Z2fnULMR1NV?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPIG>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPIG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

