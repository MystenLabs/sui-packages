module 0x315fdb4ce09e271dda542d9f4185d97e47ed5f8587ebfe404afb94b8df829649::crabby {
    struct CRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABBY>(arg0, 9, b"CRABBY", b"Crabby The Crabb", b"Grab the $CRAB. The degenerate Sui mogul, pincher of charts and normies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GiG7Hr61RVm4CSUxJmgiCoySFQtdiwxtqf64MsRppump.png?size=lg&key=543ef8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRABBY>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABBY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

