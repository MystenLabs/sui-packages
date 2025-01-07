module 0x55203d413749b420c2be91e10c8300a7dca500f98299f631ac32656037c2c961::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOODENG>, arg1: 0x2::coin::Coin<MOODENG>) {
        0x2::coin::burn<MOODENG>(arg0, arg1);
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 9, b"MOO DENG", b"Satoshi revealed", b"MOO DENG CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcTczXoQEL1jjWD8f2tT33ppVV4f6Dd569XHu6pKGskRS")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOODENG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOODENG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOODENG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

