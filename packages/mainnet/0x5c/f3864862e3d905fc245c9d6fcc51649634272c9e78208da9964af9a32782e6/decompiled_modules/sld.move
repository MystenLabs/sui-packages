module 0x5cf3864862e3d905fc245c9d6fcc51649634272c9e78208da9964af9a32782e6::sld {
    struct SLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLD>(arg0, 9, b"SLD", b"Shield One", b"Its not just a meme coin , Its the best meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4a8e21c-6cc2-4907-badc-fb0fe6a75e26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

