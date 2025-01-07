module 0x807a38a3563d8463ff86f01cfba4e078014dc2092d875a0dbc07e5a3725c6282::mongs {
    struct MONGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONGS>(arg0, 6, b"MONGS", b"https://t.me/MongSUI 500k cap today", b"https://t.me/MongSUI 500k cap today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/h0omlTj.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONGS>>(v0, @0x9471a5118275e10c44e82d8a5f21b9908b6be24b189e1809c23c7f9b43b9a807);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MONGS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MONGS>(arg0, arg1, @0x9471a5118275e10c44e82d8a5f21b9908b6be24b189e1809c23c7f9b43b9a807, arg2);
    }

    // decompiled from Move bytecode v6
}

