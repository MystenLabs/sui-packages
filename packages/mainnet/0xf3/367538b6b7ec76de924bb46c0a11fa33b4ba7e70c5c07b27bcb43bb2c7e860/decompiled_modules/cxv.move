module 0xf3367538b6b7ec76de924bb46c0a11fa33b4ba7e70c5c07b27bcb43bb2c7e860::cxv {
    struct CXV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXV>(arg0, 9, b"CXV", b"BHF", b"VXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/951b11ba-4159-4b2e-96ef-ad8fb5ce42da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CXV>>(v1);
    }

    // decompiled from Move bytecode v6
}

