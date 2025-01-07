module 0x1a3c233018e713d318fb472adb6426b91810137ca5dd5cb1e16e00d2b919632b::wartocen {
    struct WARTOCEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARTOCEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARTOCEN>(arg0, 9, b"WARTOCEN", b"WAR", b"Token of WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8684e71f-6fe9-4705-847e-bd1f1eed2c33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARTOCEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARTOCEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

