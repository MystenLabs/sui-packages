module 0xb4431b0cdc8db48f8b24fa897341e0a5d8ad75fc97e4d8f57c6a77bf92ad9172::wvr {
    struct WVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVR>(arg0, 9, b"WVR", b"Waverider", b"Token  for wave riders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62534705-31d4-4258-8ca5-3ff663001014-1000014080.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

