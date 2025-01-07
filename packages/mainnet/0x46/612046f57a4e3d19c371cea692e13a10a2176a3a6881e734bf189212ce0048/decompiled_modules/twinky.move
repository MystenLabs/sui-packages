module 0x46612046f57a4e3d19c371cea692e13a10a2176a3a6881e734bf189212ce0048::twinky {
    struct TWINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWINKY>(arg0, 9, b"TWINKY", b"Twinky", b"Super delicious TWINKY bite of the meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1663857953424949251/oOgWkFLV.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TWINKY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWINKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

