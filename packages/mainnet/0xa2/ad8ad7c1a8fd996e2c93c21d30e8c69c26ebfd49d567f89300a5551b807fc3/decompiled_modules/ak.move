module 0xa2ad8ad7c1a8fd996e2c93c21d30e8c69c26ebfd49d567f89300a5551b807fc3::ak {
    struct AK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AK>(arg0, 6, b"AK", b"AKAI", b"https://x.com/akai_agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/74ae6053-1caf-40fa-a444-1d82bc5cce35.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

