module 0xd9f4610b61f790375c03357678c3385e91cd8e5e267c686f7cec009716634647::niska {
    struct NISKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NISKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NISKA>(arg0, 6, b"NISKA", b"SUINISKA", b"NISKA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_23_21_45_0f843b4335.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NISKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NISKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

