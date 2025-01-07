module 0x71d2a742fdb777766185e0335a37dd2ed53b23ce340e8231635e9f2e849921b4::hodlhams_h {
    struct HODLHAMS_H has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODLHAMS_H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODLHAMS_H>(arg0, 9, b"HODLHAMS_H", b"HodlHams", b"Hold Tight, Stay Mighty!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30df0eeb-4b03-4a4a-9a43-4168dec1c6b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLHAMS_H>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HODLHAMS_H>>(v1);
    }

    // decompiled from Move bytecode v6
}

