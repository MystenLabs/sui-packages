module 0xda0d948e457e404a2ad7e3bb6388fe197ecb640cf6b9b25a61250030e2c1c9d2::lbs {
    struct LBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBS>(arg0, 6, b"LBS", b"Labusui", b"The teddy bear monster Labubu has appeared at SUI. Hurry up to own and collect now !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_20_21_14_f1f6358bdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

