module 0xf8d2ec009f38871ada1c26f9103bdd58f721c0e22f0bf61ce5ecdaff1330c0a::fartoshi {
    struct FARTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTOSHI>(arg0, 6, b"FARTOSHI", b"FARTOSHI AI", b"AI farted Satoshi out of existence. Welcome to the Agent $FARTOSHI world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241221_135022_849_0446a88fb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

