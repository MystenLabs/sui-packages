module 0x687378a508c0d4ba2ce27e504e77209fd5d7ee58ed0e185537573119b87aaf80::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 9, b"CC", b"CCAT", b"Memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2aadbc3e-db09-4e6d-8dec-00de88ebd84e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CC>>(v1);
    }

    // decompiled from Move bytecode v6
}

