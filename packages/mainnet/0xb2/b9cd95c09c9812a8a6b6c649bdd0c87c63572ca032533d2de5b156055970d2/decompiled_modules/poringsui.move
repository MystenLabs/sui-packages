module 0xb2b9cd95c09c9812a8a6b6c649bdd0c87c63572ca032533d2de5b156055970d2::poringsui {
    struct PORINGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORINGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORINGSUI>(arg0, 9, b"PORINGSUI", b"Poring", b"Have fun with $PORING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06ad05e2-43d2-455c-85cb-20337df2feb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORINGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORINGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

