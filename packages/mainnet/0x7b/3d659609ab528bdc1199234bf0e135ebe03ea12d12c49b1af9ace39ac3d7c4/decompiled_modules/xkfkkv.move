module 0x7b3d659609ab528bdc1199234bf0e135ebe03ea12d12c49b1af9ace39ac3d7c4::xkfkkv {
    struct XKFKKV has drop {
        dummy_field: bool,
    }

    fun init(arg0: XKFKKV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XKFKKV>(arg0, 9, b"XKFKKV", b"Yejkdk", b"Vkclkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/961dcfb3-4ce9-4c32-96ea-51d4d3007cc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XKFKKV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XKFKKV>>(v1);
    }

    // decompiled from Move bytecode v6
}

