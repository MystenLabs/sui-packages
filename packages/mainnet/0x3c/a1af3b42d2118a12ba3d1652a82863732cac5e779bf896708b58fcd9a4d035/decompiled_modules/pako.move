module 0x3ca1af3b42d2118a12ba3d1652a82863732cac5e779bf896708b58fcd9a4d035::pako {
    struct PAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAKO>(arg0, 6, b"PAKO", b"Sui Pako", b"Meet $PAKO, the penguin who cant stop dancing on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_5940c0503a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

