module 0x215f7564f9236055413b4197fa448fdfa752c3ec1c6f5b24278257f1497f3330::cca {
    struct CCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCA>(arg0, 9, b"CCA", b"CAR ", b"THIS CAR SHAKES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b375413e-2a35-4bef-8c19-423624947af8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

