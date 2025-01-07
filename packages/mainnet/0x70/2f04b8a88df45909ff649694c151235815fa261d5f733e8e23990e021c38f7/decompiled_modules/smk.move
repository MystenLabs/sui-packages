module 0x702f04b8a88df45909ff649694c151235815fa261d5f733e8e23990e021c38f7::smk {
    struct SMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMK>(arg0, 9, b"SMK", b"SMOCK", b"Let's make this meme the greatest of them all. Ready for this ride? LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8844cc60-0ef2-4565-a21d-c1c4a6512f0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

