module 0x2af0af9e40783860ca81c33d9dea845975723b09af1b02eb14e5851f81e98b27::ala {
    struct ALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALA>(arg0, 9, b"ALA", b"Alireza", b"I love u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8673561-7a78-44b9-8274-71bcc5030c5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

