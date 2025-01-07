module 0x5d52f159d5916f74e3ca120a918a2b1e02fa5059ef422e18697486e357b6daa8::insideout {
    struct INSIDEOUT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<INSIDEOUT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<INSIDEOUT>>(0x2::coin::mint<INSIDEOUT>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: INSIDEOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSIDEOUT>(arg0, 9, b"INOUT", b"INSIDEOUT", b"You are not bullish enough!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1797275856672378881/HYoSFRSr_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<INSIDEOUT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INSIDEOUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSIDEOUT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

