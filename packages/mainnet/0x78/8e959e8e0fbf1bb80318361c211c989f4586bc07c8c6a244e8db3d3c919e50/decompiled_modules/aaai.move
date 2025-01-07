module 0x788e959e8e0fbf1bb80318361c211c989f4586bc07c8c6a244e8db3d3c919e50::aaai {
    struct AAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAI>(arg0, 6, b"AAAI", b"AAA I LOST AGAIN", b"aaa im a jeeeeeeet and i lost again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qf_Q_hzrf_400x400_c6ff162195.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

