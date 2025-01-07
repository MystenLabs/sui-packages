module 0x825079e27ac55e4c63f16af8a36d233dcb0cfb5aa6224aa6630df04ed74548ac::usbsn {
    struct USBSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USBSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USBSN>(arg0, 9, b"USBSN", b"usbs", b"mdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fec05ec-1417-46f7-ace7-071bfe2498b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USBSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USBSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

