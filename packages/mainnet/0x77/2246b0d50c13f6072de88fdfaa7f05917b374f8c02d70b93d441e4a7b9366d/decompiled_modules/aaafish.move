module 0x772246b0d50c13f6072de88fdfaa7f05917b374f8c02d70b93d441e4a7b9366d::aaafish {
    struct AAAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAFISH>(arg0, 6, b"aaaFish", b"Ferocious Fish", b"The fish is not cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_13_08_02_bd3236ba0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

