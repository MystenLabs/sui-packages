module 0x3a13b5dcde845e17e50176acba8bcdbd777a2f231e11a11920a2eafe11df9c3::dgs {
    struct DGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGS>(arg0, 9, b"DGS", b"Dogs Sui", b"Dogs on sui network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e12f308-21b1-4f3f-b4d8-31e0b91c0ac9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

