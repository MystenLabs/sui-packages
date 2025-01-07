module 0xbfb9d35e8c96b001ddc6424e58495e66df81eb20711e7657052354c2d1c9e4ca::suisane {
    struct SUISANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISANE>(arg0, 9, b"SUISANE", b"Sui Android Suisane", b"Robot girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/013/714/658/large/rogier-van-de-beek-2018-29a.jpg?1540826535")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISANE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISANE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

