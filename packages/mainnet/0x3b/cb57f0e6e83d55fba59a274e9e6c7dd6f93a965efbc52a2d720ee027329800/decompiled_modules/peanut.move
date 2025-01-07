module 0x3bcb57f0e6e83d55fba59a274e9e6c7dd6f93a965efbc52a2d720ee027329800::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT>(arg0, 9, b"Peanut", b"Peanut", b"PEANUT the Squirrel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1852715847456059392/EMaL-z-B_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEANUT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEANUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

