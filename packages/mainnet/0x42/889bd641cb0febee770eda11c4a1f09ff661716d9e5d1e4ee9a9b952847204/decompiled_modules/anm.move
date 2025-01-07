module 0x42889bd641cb0febee770eda11c4a1f09ff661716d9e5d1e4ee9a9b952847204::anm {
    struct ANM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANM>(arg0, 9, b"ANM", b"Anime", b"Cool Anime toon to rock your world! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65123610-f84a-4074-bec6-39ca3f70664e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANM>>(v1);
    }

    // decompiled from Move bytecode v6
}

