module 0x2d02e5a8241f92369ee02c4719d162e189190c616f2ad6fd660285c018f5efc9::dorime {
    struct DORIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORIME>(arg0, 6, b"Dorime", b"dorime", b"dorime!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_01_44_03_a21f7c8e82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

