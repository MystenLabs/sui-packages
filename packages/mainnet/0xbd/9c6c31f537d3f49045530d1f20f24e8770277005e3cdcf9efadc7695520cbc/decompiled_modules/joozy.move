module 0xbd9c6c31f537d3f49045530d1f20f24e8770277005e3cdcf9efadc7695520cbc::joozy {
    struct JOOZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOZY>(arg0, 6, b"JOOZY", b"Joozy Podcast", x"4461707073207468617420686173207265766f6c7574696f6e697a656420746865207761792070656f706c6520696e74657261637420776974682074686520576562332e2057697468206974732066656174757265732c20616c6c6f777320757365727320746f207365616d6c6573736c7920696e7465726163742e204c61756e63686564206f6e20535549204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_13_21_34_58_10543953b1_34f71b9c18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOOZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

