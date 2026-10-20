module 0xb2e2bfcf8f3f9d9b1aa300f643f1e9ab476f1fd0e9f9054651927079b8a0bb39::nogas {
    struct NOGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGAS>(arg0, 9, b"NOGAS", b"Nogasonsui", b"No Gas, Just a Line", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2111914461720178688/B0z5W0tV_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOGAS>>(0x2::coin::mint<NOGAS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOGAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGAS>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

