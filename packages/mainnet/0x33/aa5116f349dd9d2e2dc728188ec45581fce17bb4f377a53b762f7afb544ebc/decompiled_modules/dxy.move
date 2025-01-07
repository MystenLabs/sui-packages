module 0x33aa5116f349dd9d2e2dc728188ec45581fce17bb4f377a53b762f7afb544ebc::dxy {
    struct DXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXY>(arg0, 9, b"DXY", b"DXY6900", b"US DEGEN INDEX 6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a65c1bb-89ed-49a3-9765-1a4e05c81cef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

