module 0x44ee49827705738f1f1e7ada5532154f27fb297a30a1992dd6d9b4693f353557::dmoodeng {
    struct DMOODENG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DMOODENG>, arg1: 0x2::coin::Coin<DMOODENG>) {
        0x2::coin::burn<DMOODENG>(arg0, arg1);
    }

    fun init(arg0: DMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMOODENG>(arg0, 9, b"DMOODENG", b"DARK MOODENG", b"DARK MOODENG CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXPp81MEq7SNPkYVfspcaoox2Kfea4Ji5YgeFpaVVzseJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DMOODENG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMOODENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMOODENG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

