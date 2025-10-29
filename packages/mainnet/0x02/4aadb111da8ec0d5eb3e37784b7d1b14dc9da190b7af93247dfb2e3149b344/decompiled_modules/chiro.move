module 0x24aadb111da8ec0d5eb3e37784b7d1b14dc9da190b7af93247dfb2e3149b344::chiro {
    struct CHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRO>(arg0, 9, b"CHIRO", b"CHIROMA", b"Follow the story of Issa as he explores the greatest mysteries of the universe and seeks to return to the planet he once called home with the help of the friends ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSuavLcBKECD4d7cgSM269E4sRHke3W5xVXbXjbB3nbSq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHIRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

