module 0x3659e5669cde3fc214581e4baab5231d3ea154cdd1209b66af1d1ddf221d79c0::trumpmcd {
    struct TRUMPMCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMCD>(arg0, 6, b"TrumpMCD", b"Trump McDonald's", b"Waving to everyone that faded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_X0d_B4_Xo_AEE_Lv_8a3ad260f2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPMCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

