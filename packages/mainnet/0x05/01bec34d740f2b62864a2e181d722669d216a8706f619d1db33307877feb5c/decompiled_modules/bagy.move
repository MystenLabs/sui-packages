module 0x501bec34d740f2b62864a2e181d722669d216a8706f619d1db33307877feb5c::bagy {
    struct BAGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGY>(arg0, 6, b"BAGY", b"First Bagy Sui", b"First Bagy On Sui:https://bagysui.site", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_3_cf4ea60545.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

