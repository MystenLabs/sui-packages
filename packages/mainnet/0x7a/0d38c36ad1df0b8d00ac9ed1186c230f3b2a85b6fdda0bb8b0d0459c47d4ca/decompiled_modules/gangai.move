module 0x7a0d38c36ad1df0b8d00ac9ed1186c230f3b2a85b6fdda0bb8b0d0459c47d4ca::gangai {
    struct GANGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGAI>(arg0, 9, b"GANGAI", b"GangAI Tok", b"Gang AI token for all gangsters and gamers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7ed49b1-e378-4208-b3c8-0cc323dd8bce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

