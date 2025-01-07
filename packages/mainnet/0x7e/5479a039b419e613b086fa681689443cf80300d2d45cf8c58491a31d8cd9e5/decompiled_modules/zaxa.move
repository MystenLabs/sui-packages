module 0x7e5479a039b419e613b086fa681689443cf80300d2d45cf8c58491a31d8cd9e5::zaxa {
    struct ZAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAXA>(arg0, 9, b"ZAXA", b"ZAXA VAU", b"TEAM WORK IS THE KEY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa264886-0fdb-4bea-8d4e-1966d46e7293.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

