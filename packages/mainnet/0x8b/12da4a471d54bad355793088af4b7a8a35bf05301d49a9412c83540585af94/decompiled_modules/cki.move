module 0x8b12da4a471d54bad355793088af4b7a8a35bf05301d49a9412c83540585af94::cki {
    struct CKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKI>(arg0, 9, b"CKI", b"kind cat", b"Cute and funny and practical", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd0a9121-c15e-478c-9a4e-6a3c7d5e4d94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

