module 0xd3e1571d2ace18d58f66d197bf181f5fcc9d308c866db86cc9455729011babce::roll {
    struct ROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLL>(arg0, 9, b"ROLL", b"Rick Roll", b"Rick Astley - Never Gonna Give You Up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.vox-cdn.com/thumbor/wfbQ3XccV6SxGMt1l6zBPL3Xg7o=/0x0:1192x795/1400x1050/filters:focal(596x398:597x399)/cdn.vox-cdn.com/uploads/chorus_asset/file/22312759/rickroll_4k.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROLL>(&mut v2, 3320000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

