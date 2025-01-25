module 0x3442eb837007cfcce8659f375f3b04c7429fe992dabc407dd8afe4b837355cdc::lds {
    struct LDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDS>(arg0, 6, b"LDS", b"LoyalDoge on sui", b"Together build a strong, united and developed LoyalDoge community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_003fba47d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

