module 0x13e40b9b90dd980b591234f16828deb05528d5bed8bced3c23323d2b8638a5dd::hdalkf {
    struct HDALKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDALKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDALKF>(arg0, 9, b"HDALKF", b"Hello ", b"asdsdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1eb045bf-4974-4a08-81d7-b3632e4d1847.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDALKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDALKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

