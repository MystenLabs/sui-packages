module 0x319b735d2fb9131ecaf3201d27bd945e17f43bad0b5bbbf4fcfd94d71e07ec26::tylk {
    struct TYLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYLK>(arg0, 9, b"TYLK", b"Tuyulan", b"Buat nuyul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15dbac4e-ab48-4b22-bb45-bac037f87f9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

