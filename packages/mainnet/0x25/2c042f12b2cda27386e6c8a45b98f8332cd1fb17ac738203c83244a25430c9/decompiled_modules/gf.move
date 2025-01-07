module 0x252c042f12b2cda27386e6c8a45b98f8332cd1fb17ac738203c83244a25430c9::gf {
    struct GF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GF>(arg0, 6, b"GF", b"Ghost Fish", x"e2809c47686f7374204669736820f09f8c8a207c20446565702d736561206578706c6f726572207c20446976696e6720696e746f206d79737465726965732c206f6e6520706978656c20617420612074696d652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730436444637.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

