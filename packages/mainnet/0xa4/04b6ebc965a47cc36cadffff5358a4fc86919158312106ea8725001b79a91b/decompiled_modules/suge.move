module 0xa404b6ebc965a47cc36cadffff5358a4fc86919158312106ea8725001b79a91b::suge {
    struct SUGE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUGE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUGE>>(0x2::coin::mint<SUGE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGE>(arg0, 9, b"SUGE", b"SUGE", b"Are you looking for Ai agents?You wont find them with SUGE we are old school a community meme with hard grip.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1462906715335237640/EUlrWB9I_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

