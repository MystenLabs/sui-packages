module 0x8b1d7a76c497604ec33275ff090606ac1a32a4b8f447d312e897ffc5984eba5d::icee {
    struct ICEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICEE>(arg0, 6, b"ICEE", b"ICE EEL SUI", x"4d616b65206974204963652045656c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/raf_360x360_075_t_fafafa_ca443f4786_removebg_preview_e1e9d912c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

