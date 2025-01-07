module 0x43d57acf58c56af3afccc5daf3424faa619c5f2ec88a17936f083ee2e4205137::playlist {
    struct PLAYLIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAYLIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAYLIST>(arg0, 9, b"PLAYLIST", b"PLAYLIST", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLAYLIST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAYLIST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLAYLIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

