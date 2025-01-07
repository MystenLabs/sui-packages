module 0xbbf139ddd783159b44d1e4bb425d85d55381b31782ae1b46636dcaa860c98ea1::gvtv {
    struct GVTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GVTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GVTV>(arg0, 9, b"GVTV", b"Hbhg", b"Hvhv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5109d9b8-938e-417e-9856-88434fcf132c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GVTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GVTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

