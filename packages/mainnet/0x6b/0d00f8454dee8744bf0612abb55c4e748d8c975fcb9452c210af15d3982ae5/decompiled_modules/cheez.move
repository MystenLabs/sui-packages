module 0x6b0d00f8454dee8744bf0612abb55c4e748d8c975fcb9452c210af15d3982ae5::cheez {
    struct CHEEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEZ>(arg0, 9, b"CHEEZ", b"MoonCheese", b" The tastiest moon-based currency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b74f55b0-14a4-4e0b-b7d1-508ac6f73b0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

