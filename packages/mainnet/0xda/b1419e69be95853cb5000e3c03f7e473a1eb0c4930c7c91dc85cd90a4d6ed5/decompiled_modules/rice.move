module 0xdab1419e69be95853cb5000e3c03f7e473a1eb0c4930c7c91dc85cd90a4d6ed5::rice {
    struct RICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICE>(arg0, 9, b"RICE", b"Ricefield", b"Main food of Asian people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1c0dce8-b605-43ad-b1bd-2913e4cb353b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

