module 0xe9ba1a33dc6dedd4cb38d257c8c72a320e88c0ed7942c55c15ae787e233e57f3::dogf {
    struct DOGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGF>(arg0, 6, b"DogF", b"Dog FLA", b"meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7e96fca5_872f_4d9f_bcc7_462ad770b2aa_4255017b83.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

