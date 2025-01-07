module 0xd762dfa8cb5499917bf0f28007b433a4f9db0a241a2345ddbca1845400e14c81::ktfl {
    struct KTFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTFL>(arg0, 9, b"KTFL", b"kittyfly", b"Happy spotty flying kitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b74c275-0316-441d-b14e-f9184ba9389a-1000008912.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

