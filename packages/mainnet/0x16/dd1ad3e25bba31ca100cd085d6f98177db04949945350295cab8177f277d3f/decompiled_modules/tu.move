module 0x16dd1ad3e25bba31ca100cd085d6f98177db04949945350295cab8177f277d3f::tu {
    struct TU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TU>(arg0, 9, b"TU", b"TRUMP", b"Memes about president donald trump are humorous and cheer for him to become the new president", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/796570a4-d9d8-4b5d-93bf-04473230aec5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TU>>(v1);
    }

    // decompiled from Move bytecode v6
}

