module 0x155cb586484c02d45f1e39f23983a25fac4da609a3d39e62959329eb330a4ff9::mctrump {
    struct MCTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCTRUMP>(arg0, 6, b"McTrump", b"McDonaldTrump", b"President DonaldTrump working the Drive Thru at McDonalds! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241020_204504_d2fda0703b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

