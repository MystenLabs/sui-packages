module 0xcba724f0818227ca8cc1697487304400246dc088bc021d954c71f01690f1f262::anm {
    struct ANM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANM>(arg0, 9, b"ANM", b"Anime", b"Cool Anime toon to rock your world! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fa5aa55-37c7-49a1-8cd1-c35f7c1f514c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANM>>(v1);
    }

    // decompiled from Move bytecode v6
}

