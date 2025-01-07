module 0xc7b696a36ec64659c23b41de160f9cead7d75272f93f669f2b4eec301dafc26c::wwe {
    struct WWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWE>(arg0, 9, b"WWE", b"WENWE", b"Get in if you are this imaginative.. this is an imaginative meme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/536cb3c6-f1cd-4b1a-8e07-0c41d1e73fdf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

