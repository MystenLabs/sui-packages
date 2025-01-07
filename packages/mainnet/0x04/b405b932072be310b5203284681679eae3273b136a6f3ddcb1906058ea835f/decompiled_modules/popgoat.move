module 0x4b405b932072be310b5203284681679eae3273b136a6f3ddcb1906058ea835f::popgoat {
    struct POPGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPGOAT>(arg0, 9, b"POPGOAT", b"Pop Goat", b"Pop Cat hit 1.3 Mcap , Pop Goat soon !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1850890629947285504/3vaDvDKm.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPGOAT>(&mut v2, 450000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPGOAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

