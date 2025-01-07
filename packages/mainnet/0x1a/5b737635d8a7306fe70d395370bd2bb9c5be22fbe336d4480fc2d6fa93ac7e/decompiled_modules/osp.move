module 0x1a5b737635d8a7306fe70d395370bd2bb9c5be22fbe336d4480fc2d6fa93ac7e::osp {
    struct OSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSP>(arg0, 6, b"OSP", b"ONE SUI PIECE", b"The journey of the man with a hat on SUI has began.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_29_5ea807cfd3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

