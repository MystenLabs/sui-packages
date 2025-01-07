module 0x3d664fd4040b05099da86817fb361150b817a7d6e3644b870c7c29d0c6cf3195::oneye {
    struct ONEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEYE>(arg0, 9, b"ONEYE", b"Zuko", b"Zuko the famous shiba inu with one eye.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9dbe3c8-dd5f-4710-8cae-4b465e2ececc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

