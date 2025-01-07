module 0xa4c9c028e0d7dd90c674ca7ad63002bbd41584981d9a2ab537b81614a7b2b140::wifwif {
    struct WIFWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFWIF>(arg0, 6, b"WIFWIF", b"WifWifHat", x"24576966576966486174202257686572657665722049206c6179206d79206861742c206973206d7920686f6d65220a43726f7373636861696e206d656d65636f696e20746f20656e642074686520646976696465202d20456d62726163652065616368206f74686572202d204a6f696e207468652066756e0a0a4144410a534f4c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WIF_4_0f7715850f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

