module 0x490ac2cfe4709e3579438ec6178a7e46ade8a0681145de28cc8dccfef495dda2::popdeng {
    struct POPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENG>(arg0, 6, b"PopDeng", b"POP DENG on SUI", x"4974206d69676874206e6f742062652065617379200a497473206d6967687420626520736c6f77200a4974206d69676874206e6f742062652077697365200a0a427574206f6e6c79206f6e65204d656d65636f696e2063616e206368616e676520796f7572206c6966652021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_132639_023e8a1fea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

