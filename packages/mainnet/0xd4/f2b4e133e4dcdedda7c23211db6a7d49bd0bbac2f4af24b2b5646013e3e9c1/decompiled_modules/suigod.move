module 0xd4f2b4e133e4dcdedda7c23211db6a7d49bd0bbac2f4af24b2b5646013e3e9c1::suigod {
    struct SUIGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOD>(arg0, 6, b"SUIGOD", b"SUIJIN GOD", x"20546865205375696a696e2069732074686520677561726469616e206465697479206f662077617465722028737569290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3528_ca2e0d4d01.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

