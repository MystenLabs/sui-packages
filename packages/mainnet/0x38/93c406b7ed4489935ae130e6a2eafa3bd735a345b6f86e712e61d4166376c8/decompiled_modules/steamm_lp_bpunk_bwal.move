module 0x3893c406b7ed4489935ae130e6a2eafa3bd735a345b6f86e712e61d4166376c8::steamm_lp_bpunk_bwal {
    struct STEAMM_LP_BPUNK_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BPUNK_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BPUNK_BWAL>(arg0, 9, b"STEAMM LP bPUNK-bWAL", b"STEAMM LP Token bPUNK-bWAL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BPUNK_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BPUNK_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

