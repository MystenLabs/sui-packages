module 0x6b2610c9f11ceea6729bd2150853b90d5e25a679d510238fc1ababee9577a73d::perucoin {
    struct PERUCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERUCOIN>(arg0, 6, b"Perucoin", b"Perucoin on SUI", b"Perucoin on SUI. Send It to Milli!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051711_04d63c001f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERUCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERUCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

