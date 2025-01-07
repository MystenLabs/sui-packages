module 0x359c1a86e4da4c8b636aa3bdcee3ef99e16a3f54e66d3c14501e410136c54579::sado {
    struct SADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADO>(arg0, 9, b"SADO", b"Shadow TM", b"Shadow Squad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2bbdcfb-b47c-4ea7-952d-eb70e1de8290.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

