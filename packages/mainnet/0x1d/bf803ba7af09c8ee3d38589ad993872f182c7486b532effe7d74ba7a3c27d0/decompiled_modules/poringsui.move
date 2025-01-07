module 0x1dbf803ba7af09c8ee3d38589ad993872f182c7486b532effe7d74ba7a3c27d0::poringsui {
    struct PORINGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORINGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORINGSUI>(arg0, 9, b"PORINGSUI", b"Poring", b"Have fun with $PORING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b83cab44-ff34-4f9d-af74-a735deb4f1f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORINGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORINGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

