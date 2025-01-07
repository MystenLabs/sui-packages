module 0x5dcc843e071ff38030100b3c2d89f92c563be42dc4afeb3597a05ec3ac9e6fa9::googy {
    struct GOOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGY>(arg0, 9, b"GOOGY", b"GOOG", b"Best stock moves Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1792891265974931456/MJN4-Eln.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOOGY>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

