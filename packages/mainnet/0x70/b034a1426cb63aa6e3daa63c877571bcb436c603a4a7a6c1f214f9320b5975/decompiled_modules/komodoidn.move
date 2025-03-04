module 0x70b034a1426cb63aa6e3daa63c877571bcb436c603a4a7a6c1f214f9320b5975::komodoidn {
    struct KOMODOIDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMODOIDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMODOIDN>(arg0, 9, b"KOMODOIDN", b"KOMODO", b"KOMODO animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/687a9db4-ea68-4647-9590-533a8bc0f338.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMODOIDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOMODOIDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

