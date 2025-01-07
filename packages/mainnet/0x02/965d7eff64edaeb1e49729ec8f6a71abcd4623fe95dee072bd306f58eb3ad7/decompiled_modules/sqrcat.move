module 0x2965d7eff64edaeb1e49729ec8f6a71abcd4623fe95dee072bd306f58eb3ad7::sqrcat {
    struct SQRCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQRCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQRCAT>(arg0, 6, b"SQRCAT", b"Sqr Cat", b"Yes my head is square", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_01_54_40_d97a944b40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQRCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQRCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

