module 0x70386dc956a3c819395008351fb27249ec3da2cb6af877bb86d3ca1247d254e4::suizee {
    struct SUIZEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZEE>(arg0, 6, b"SuiZee", b"CZ IS BACK", b"The king is back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0414_88f522b2a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

