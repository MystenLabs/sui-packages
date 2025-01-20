module 0x12c0fadece10b8f6d9b4fe248826a0c42edb81f86267c224af72382c0a18dead::saylor {
    struct SAYLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAYLOR>(arg0, 9, b"SAYLOR", b"SAYLOR Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/4tMT3mjqgJ2LCKa6cLxS2n8JGCZXmYPNtAgEVmU1pump.png?size=lg&key=e18884"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAYLOR>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAYLOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYLOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

