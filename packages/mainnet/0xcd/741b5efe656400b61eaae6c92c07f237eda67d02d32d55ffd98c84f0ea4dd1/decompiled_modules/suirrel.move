module 0xcd741b5efe656400b61eaae6c92c07f237eda67d02d32d55ffd98c84f0ea4dd1::suirrel {
    struct SUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRREL>(arg0, 6, b"SUIRREL", b"Suirrel", b"Blue Sui Squirrel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirrel1_b928e52e28.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRREL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRREL>>(v1);
    }

    // decompiled from Move bytecode v6
}

