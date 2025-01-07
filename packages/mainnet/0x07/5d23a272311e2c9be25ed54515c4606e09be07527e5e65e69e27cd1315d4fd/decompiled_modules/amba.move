module 0x75d23a272311e2c9be25ed54515c4606e09be07527e5e65e69e27cd1315d4fd::amba {
    struct AMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBA>(arg0, 9, b"AMBA", b"Ambatukam ", b"Ambatukam ooouuuhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/962fef2a-d1a0-4223-b157-0ed1316d4d99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

