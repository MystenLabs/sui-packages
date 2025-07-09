module 0x7f231ae5ded07840450d70c3f678df00ce6f6aa900b2abc3b87dba7b37219504::raichusui {
    struct RAICHUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAICHUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAICHUSUI>(arg0, 9, b"RAISUI", b"Raichusui", b"An orange electric rodent with a lightning tail curving into the Sui emblem, zapping Sui coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAICHUSUI>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAICHUSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAICHUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

