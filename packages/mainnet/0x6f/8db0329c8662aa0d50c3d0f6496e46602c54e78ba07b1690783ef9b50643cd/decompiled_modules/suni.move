module 0x6f8db0329c8662aa0d50c3d0f6496e46602c54e78ba07b1690783ef9b50643cd::suni {
    struct SUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNI>(arg0, 9, b"SUNI", b"SuniSwap", b"SuniSwap next generation ag for sui with many upcoming airdrops.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1438315556608770049/2RJYDD73_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUNI>(&mut v2, 250000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

