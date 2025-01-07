module 0x426d18bb28ab0772e082c8af76ea3e65fbd60859df890666a39e91ff85c31037::esti {
    struct ESTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTI>(arg0, 6, b"ESTI", b"Esti dog", b"Community take over meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S0_U_Bvvt9_400x400_0f92bee92d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

