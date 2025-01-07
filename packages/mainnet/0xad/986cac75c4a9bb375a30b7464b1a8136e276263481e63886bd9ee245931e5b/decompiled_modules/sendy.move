module 0xad986cac75c4a9bb375a30b7464b1a8136e276263481e63886bd9ee245931e5b::sendy {
    struct SENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENDY>(arg0, 6, b"SENDY", b"SENDY SUI", b"inspired by a based Matt Furie character came to conquer Dog Meta on sui chain. The next banger to the 'Boys Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_05_15_6c3075f83f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

