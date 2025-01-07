module 0x62ec2bc3ab6061d07e9bb554b263f000f719db43b61bb6d164b784dffa8adb00::drm {
    struct DRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRM>(arg0, 9, b"DRM", b"Dream", x"50726f6261626c79206e6f7468696e67e280a620427574206d6179626520736f6d657468696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1e2dac7-40f4-4afc-850a-b8387b1fb2f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

