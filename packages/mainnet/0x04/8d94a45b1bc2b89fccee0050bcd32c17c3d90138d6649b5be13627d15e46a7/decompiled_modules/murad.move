module 0x48d94a45b1bc2b89fccee0050bcd32c17c3d90138d6649b5be13627d15e46a7::murad {
    struct MURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAD>(arg0, 6, b"MURAD", b"SUI MURAD", b" $MURAD is the god of memes rn . His shills are touching billions.. Let's start the bullrun with $MURAD .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C6408076_6_D05_4_E37_9457_7_FBDB_8_FFA_147_df7e1f4d51.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

