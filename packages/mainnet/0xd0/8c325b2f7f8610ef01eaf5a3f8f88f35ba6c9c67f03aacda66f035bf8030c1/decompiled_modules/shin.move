module 0xd08c325b2f7f8610ef01eaf5a3f8f88f35ba6c9c67f03aacda66f035bf8030c1::shin {
    struct SHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIN>(arg0, 9, b"SHIN", b"Shinshin", b"Shin is the naught meme but he is so cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70bc67e0-68cb-462c-87a5-b32df9443150.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

