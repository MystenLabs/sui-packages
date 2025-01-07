module 0x40fcc6213d382a82ca97a4e09875cb349ea661be0050b3cf12e352b6acf429b1::fear {
    struct FEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEAR>(arg0, 9, b"FEAR", b"FOMO", b"Fear of missing opportunity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3488dde-91df-450b-b4d2-35ee57129c4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

