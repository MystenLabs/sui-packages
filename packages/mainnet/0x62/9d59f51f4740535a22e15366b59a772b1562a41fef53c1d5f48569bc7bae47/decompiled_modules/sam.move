module 0x629d59f51f4740535a22e15366b59a772b1562a41fef53c1d5f48569bc7bae47::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 6, b"SAM", b"Sam Blackshear Move Again", b"we voting for: Sam Blackshear ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbn_R_Qy4_Xc_AAIC_18_bf5e23103c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

