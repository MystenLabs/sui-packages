module 0x8e7a469044587434de26ade9ae12a216cf1f04df6d473fab4621d51f4332bb89::shiro {
    struct SHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIRO>(arg0, 6, b"SHIRO", b"Shiro cat", b"Shiro is a funny cat.     0x9328d1de08598c344ad3e5bdbbf8ccd62a2d9226dc6e5dbfa9e1d44c388ff881::shiro::SHIRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1110_d2cdcb5d02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

