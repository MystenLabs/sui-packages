module 0x1a45d4da54e4dbd6ff68559316ad6c0209f44daca581cedfff56a222f85a56dc::goldkedi {
    struct GOLDKEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDKEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDKEDI>(arg0, 6, b"goldkedi", b"MEHMETkedi", b"tewst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1777306322846851073/VunruzU2_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDKEDI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDKEDI>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDKEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

