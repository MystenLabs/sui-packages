module 0x55e5a139166b7c935013a21a4c754a1ede44eba1839974db78b7c10b2ecf89ee::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT>(arg0, 6, b"SAT", b"Seal Cat", b"Seal Soul, Cat Vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_15_02_23_57_5f9d0dcf1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

