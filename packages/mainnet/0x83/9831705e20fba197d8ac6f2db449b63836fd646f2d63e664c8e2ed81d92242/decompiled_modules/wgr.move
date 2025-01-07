module 0x839831705e20fba197d8ac6f2db449b63836fd646f2d63e664c8e2ed81d92242::wgr {
    struct WGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGR>(arg0, 9, b"WGR", b"Wagner", b"Orchestra", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cba064f4-300a-4fec-8ee9-86e2d94a7329.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

