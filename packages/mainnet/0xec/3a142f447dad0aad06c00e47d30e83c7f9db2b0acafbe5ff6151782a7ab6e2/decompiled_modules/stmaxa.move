module 0xec3a142f447dad0aad06c00e47d30e83c7f9db2b0acafbe5ff6151782a7ab6e2::stmaxa {
    struct STMAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STMAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STMAXA>(arg0, 9, b"STMAXA", b"Stmax", b"Stma----SSSSSSSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8e94502-1ac2-4c15-9c65-e3263e4f2c9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STMAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STMAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

