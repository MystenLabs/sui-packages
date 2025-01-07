module 0xbe3cc15db9e21aeec315167072cc758831fce137631fc9de9044989bd38842ea::peniscoin {
    struct PENISCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENISCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENISCOIN>(arg0, 9, b"PENISCOIN", b"Penis Coin", b"$POPPY Hippo hooray! The zoo is excited to announce a heartwarming addition to Richmond's ZOO animal family just in time for the holidays: a baby pygmy hippo. The newborn arrived on December 9, 2024, after a 7-month gestation. Congratulations to pygmy hippo parents Iris and Corwin on the birth of another little girl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmcxd7gJSoGAygebRnq3SYDPU1jUPvuFSGeZLTriEqiYvP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENISCOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENISCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENISCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

