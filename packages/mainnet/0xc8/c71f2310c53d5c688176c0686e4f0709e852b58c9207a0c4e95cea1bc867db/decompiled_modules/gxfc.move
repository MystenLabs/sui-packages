module 0xc8c71f2310c53d5c688176c0686e4f0709e852b58c9207a0c4e95cea1bc867db::gxfc {
    struct GXFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GXFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GXFC>(arg0, 6, b"GXFC", b"Gong Xi Fa Cai", x"476f6e67205869204661204361690a476574207269636820616c6c206f6620796f750a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730983290806.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GXFC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GXFC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

