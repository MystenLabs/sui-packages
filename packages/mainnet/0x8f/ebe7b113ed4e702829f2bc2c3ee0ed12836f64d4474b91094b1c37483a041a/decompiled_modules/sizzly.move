module 0x8febe7b113ed4e702829f2bc2c3ee0ed12836f64d4474b91094b1c37483a041a::sizzly {
    struct SIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZZLY>(arg0, 6, b"SIZZLY", b"SUIZZLY CTO", b"This is CTO token, make dev rekt!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3837_2a2dd05214.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

