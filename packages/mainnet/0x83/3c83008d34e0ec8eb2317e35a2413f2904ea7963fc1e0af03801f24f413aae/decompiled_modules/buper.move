module 0x833c83008d34e0ec8eb2317e35a2413f2904ea7963fc1e0af03801f24f413aae::buper {
    struct BUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUPER>(arg0, 9, b"BUPER", b"Bup", b"Nakamoto sitawiwi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79484e45-d819-469c-8e19-465a29ef109e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

