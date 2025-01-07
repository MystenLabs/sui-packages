module 0xce5fa703d7f48737c9cfd24608337f9b9866e6b054e530a4ecd7b6b439a6c59::ctfx {
    struct CTFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTFX>(arg0, 9, b"CTFX", b"CATSFOX", b"Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9b3ca64-565b-4412-be56-8a10852b127e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTFX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTFX>>(v1);
    }

    // decompiled from Move bytecode v6
}

