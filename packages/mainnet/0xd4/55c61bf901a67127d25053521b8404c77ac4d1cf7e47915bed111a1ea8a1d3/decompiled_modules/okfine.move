module 0xd455c61bf901a67127d25053521b8404c77ac4d1cf7e47915bed111a1ea8a1d3::okfine {
    struct OKFINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKFINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKFINE>(arg0, 9, b"OKFINE", b"DOGOK", b"LIVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d15db93-6875-4b34-963d-8d9e0ca716ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKFINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKFINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

