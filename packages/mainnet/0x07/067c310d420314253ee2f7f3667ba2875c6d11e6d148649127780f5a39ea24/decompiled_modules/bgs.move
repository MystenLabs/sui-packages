module 0x7067c310d420314253ee2f7f3667ba2875c6d11e6d148649127780f5a39ea24::bgs {
    struct BGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGS>(arg0, 6, b"BGS", b"BLUE GOKU SUI", b"POWER OF BLUE GOKU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_29_11_53_41_36a434b9d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

