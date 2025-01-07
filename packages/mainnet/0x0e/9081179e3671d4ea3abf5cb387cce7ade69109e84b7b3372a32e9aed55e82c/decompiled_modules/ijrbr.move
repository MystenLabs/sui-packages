module 0xe9081179e3671d4ea3abf5cb387cce7ade69109e84b7b3372a32e9aed55e82c::ijrbr {
    struct IJRBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IJRBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IJRBR>(arg0, 9, b"IJRBR", b"bdjd", b"hdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8d3d49e-8afa-4395-a0cf-3749c13acee9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IJRBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IJRBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

