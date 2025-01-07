module 0xa02eea6613066e501a9f00060796b101ec456498bf8f6968de60c982a17b58a3::notmeme {
    struct NOTMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTMEME>(arg0, 9, b"NOTMEME", b"HOMUNKULUS", b"NOT MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0e4f9db-c7fa-4f19-8131-40ef0d7c0072-IMG_2693.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

