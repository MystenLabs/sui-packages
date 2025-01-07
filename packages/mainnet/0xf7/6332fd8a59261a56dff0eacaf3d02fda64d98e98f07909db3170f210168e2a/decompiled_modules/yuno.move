module 0xf76332fd8a59261a56dff0eacaf3d02fda64d98e98f07909db3170f210168e2a::yuno {
    struct YUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUNO>(arg0, 6, b"YUNO", b"Y U No Guy", b"2002 vibes, 2024 memes. Y U No Guy connects the dots. - $YUNO deployed on Solana now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_N_0rd4f_400x400_fd4be600e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

