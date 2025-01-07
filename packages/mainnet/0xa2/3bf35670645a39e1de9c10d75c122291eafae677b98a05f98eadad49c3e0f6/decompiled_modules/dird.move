module 0xa23bf35670645a39e1de9c10d75c122291eafae677b98a05f98eadad49c3e0f6::dird {
    struct DIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIRD>(arg0, 9, b"DIRD", b"Dirdu Sweu", b"Probably something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a293e35-5916-4edd-96d6-a2eb3105546c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

