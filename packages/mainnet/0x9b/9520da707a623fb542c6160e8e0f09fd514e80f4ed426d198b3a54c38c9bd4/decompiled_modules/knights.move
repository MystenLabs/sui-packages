module 0x9b9520da707a623fb542c6160e8e0f09fd514e80f4ed426d198b3a54c38c9bd4::knights {
    struct KNIGHTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNIGHTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNIGHTS>(arg0, 6, b"KNIGHTS", b"Knights of the Rotund Table", b"Moo Deng, Hua Hua & Pesto  - Knights of the Rotund Table", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_Ou_WOEZA_400x400_2b13e2d9e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNIGHTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNIGHTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

