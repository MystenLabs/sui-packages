module 0x658dc796722d0a1f26a33aacb08406779fec1045269cb3052538920bcf66070b::suitoby {
    struct SUITOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOBY>(arg0, 6, b"SUITOBY", b"TOBY", b"$TOBY is simply a Memecoin sui exist for fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3518_53371c9fe4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

