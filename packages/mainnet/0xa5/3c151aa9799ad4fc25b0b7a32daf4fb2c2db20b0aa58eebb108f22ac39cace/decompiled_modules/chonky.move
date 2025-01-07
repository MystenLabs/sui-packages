module 0xa53c151aa9799ad4fc25b0b7a32daf4fb2c2db20b0aa58eebb108f22ac39cace::chonky {
    struct CHONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONKY>(arg0, 6, b"CHONKY", b"CHONKY on SUI", b"OH LAWD HE COMIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W_Je9_M_b_J_400x400_bb8a3f99d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

