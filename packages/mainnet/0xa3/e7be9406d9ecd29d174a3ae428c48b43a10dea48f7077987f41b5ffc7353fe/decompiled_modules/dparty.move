module 0xa3e7be9406d9ecd29d174a3ae428c48b43a10dea48f7077987f41b5ffc7353fe::dparty {
    struct DPARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPARTY>(arg0, 6, b"Dparty", b"Diddy Party", b"Oil up , this party`s bout to get wild", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_20_40_01_83b7cd94ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPARTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

