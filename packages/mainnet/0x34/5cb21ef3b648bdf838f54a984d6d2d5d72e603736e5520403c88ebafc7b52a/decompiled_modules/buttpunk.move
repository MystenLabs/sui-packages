module 0x345cb21ef3b648bdf838f54a984d6d2d5d72e603736e5520403c88ebafc7b52a::buttpunk {
    struct BUTTPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTPUNK>(arg0, 6, b"BUTTPUNK", b"Buttpunk", b"Butt Punk Coin was created with an ultimate goal: to establish a hub for those passionate about alternative culture and to serve as the premier media launchpad for creators within that scene.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070207_8da9c4614f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTPUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTPUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

