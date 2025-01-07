module 0x122dcdbe3a894f927e34fbac3f67c469a5f4482aa53bb4bdeda26f56dd72d22d::buzz {
    struct BUZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUZZ>(arg0, 9, b"BUZZ", b"Hive AI", b"Simplifying DeFi through on-chain agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme1AwRhgU8LVpLHzVGpKrRzUEUwMjMxS4GAbarmrFoiEJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUZZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUZZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

