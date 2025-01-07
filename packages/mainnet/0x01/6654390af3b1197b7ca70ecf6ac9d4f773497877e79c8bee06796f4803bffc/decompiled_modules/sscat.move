module 0x16654390af3b1197b7ca70ecf6ac9d4f773497877e79c8bee06796f4803bffc::sscat {
    struct SSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSCAT>(arg0, 9, b"SSCAT", b"SushiSwapC", b" A fusion of flavor and feline", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/852aeba8-1ced-4934-bdc4-b0328e539c2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

