module 0x73a0ce5e4f66104334fb726ddda70e6d03b54abdbadc7732af2383c3cfcdbee3::wawe {
    struct WAWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWE>(arg0, 9, b"WAWE", b"Wawe og", b"Real wawe og", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64340bfd-452c-4ae1-a015-b88275e4d01f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

