module 0x1921a74124144e55c11379d315bce73ae5c39041f2cc4a6a5a32c838fd0f952d::suij {
    struct SUIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJ>(arg0, 6, b"SUIJ", b"Suijak", b"Suijak is the new Sui maskot of culture memes! Each of us is to some point a suijak inside!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZQQ_Xh_Q_Wc_AARC_Yw_1_e50963a68b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

