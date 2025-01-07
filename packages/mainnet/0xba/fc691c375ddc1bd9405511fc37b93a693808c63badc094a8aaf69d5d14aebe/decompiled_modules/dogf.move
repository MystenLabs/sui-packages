module 0xbafc691c375ddc1bd9405511fc37b93a693808c63badc094a8aaf69d5d14aebe::dogf {
    struct DOGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGF>(arg0, 6, b"DogF", b"Dog FLA", b"meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7e96fca5_872f_4d9f_bcc7_462ad770b2aa_cca140c457.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

