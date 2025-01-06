module 0xc7af1f16af8db0209de47ce8013866ea05c760bc7f6c67f0c63afab94e6691db::catss {
    struct CATSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSS>(arg0, 6, b"CATss", b"CATsss", b"Trend of your future...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020191_203e21bdcb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

