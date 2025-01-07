module 0x61dddee7c8ce5691e03eb02f4b84cbc145e669164aedba796c6ec9a451ab89ad::sbad {
    struct SBAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBAD>(arg0, 6, b"sBAD", b"SUIBAD", b"Bad Boys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F14bh_KEWIA_Qqrz_H_dde00efc18.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

