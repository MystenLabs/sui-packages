module 0xb609daa3f3446b795fbba4822638337e2ebfa0b72a4e3f821d4d80d26ee2e444::cbu {
    struct CBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBU>(arg0, 9, b"CBU", b"CalicoBush", x"4120637574652063616c69636f2063617420c3ad73206869c491696e6720696e2074686520677220c3a17373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f02cf4b7-8a52-4930-965a-3539d615e400.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

