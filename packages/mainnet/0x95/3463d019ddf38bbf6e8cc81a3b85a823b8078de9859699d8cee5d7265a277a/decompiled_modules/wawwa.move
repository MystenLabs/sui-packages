module 0x953463d019ddf38bbf6e8cc81a3b85a823b8078de9859699d8cee5d7265a277a::wawwa {
    struct WAWWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWWA>(arg0, 9, b"WAWWA", b"Wawawa", b"it's very funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/074c79ab-dedb-4b46-a0df-8e04a5102f90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

