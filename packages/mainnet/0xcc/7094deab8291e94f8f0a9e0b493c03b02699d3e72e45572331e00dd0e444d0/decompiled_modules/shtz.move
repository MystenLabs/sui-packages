module 0xcc7094deab8291e94f8f0a9e0b493c03b02699d3e72e45572331e00dd0e444d0::shtz {
    struct SHTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHTZ>(arg0, 6, b"Shtz", b"Shitzu", b"Shitzu on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/token_0xshitzu_near_76be8c2ff6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHTZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHTZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

