module 0xd98b636aa1baa4f5d68fe68b6ba46a24461718c28c8253b9d15f0a952a26018b::naka {
    struct NAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKA>(arg0, 6, b"NAKA", b"NAKAMOTO", b"token of nakamoto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3615896f_05af_48f4_881e_4971e9dc69fd_e360a47b43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

