module 0x1779cc166517fc9617faff01a3d5ff973b0f6f4801fb13037a234f3c0882789e::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 9, b"POPPY", b"POPPY on SUI", b"$POPPY Hippo hooray! The zoo is excited to announce a heartwarming addition to Richmond's ZOO animal family just in time for the holidays: a baby pygmy hippo. The newborn arrived on December 9, 2024, after a 7-month gestation. Congratulations to pygmy hippo parents Iris and Corwin on the birth of another little girl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmcxd7gJSoGAygebRnq3SYDPU1jUPvuFSGeZLTriEqiYvP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

