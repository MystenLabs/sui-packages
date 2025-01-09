module 0xad60afbb62a2d4159dda23d6f42643e98fe1a7f3d85fd01dc67af069d7b661ad::squad {
    struct SQUAD has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQUAD>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUAD>>(0x2::coin::mint<SQUAD>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAD>(arg0, 9, b"SQUAD", b"SQUAD", b"Chads forming a SQUAD they integrate AI, shilling, hype at enormous levels getting rich together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1434140308288147461/hq86s496_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUAD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

