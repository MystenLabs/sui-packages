module 0x34f85028c50db05428435c7699b8d9a7e3a064b97dc5dd758d9f8e0a10eeeb42::xr {
    struct XR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XR>(arg0, 9, b"XR", b"XRADERS", b"Providing actionable insights to users, enhancing trading experience. $XR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c1f2bf5-8419-4595-aaa1-d044f75b32a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XR>>(v1);
    }

    // decompiled from Move bytecode v6
}

