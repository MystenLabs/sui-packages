module 0x55ed9652288041e2fd3073feecf2eba6dfc70fbb9d40cf7b83268f5dece4710f::draco {
    struct DRACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRACO>(arg0, 6, b"Draco", b"DraconiSUI", b"Draconis is an enormous amphibian, far larger than any known species", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241128_034629_880_18af9e09f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

