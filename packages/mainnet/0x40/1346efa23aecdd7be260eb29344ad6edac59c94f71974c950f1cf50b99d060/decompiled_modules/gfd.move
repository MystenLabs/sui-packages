module 0x401346efa23aecdd7be260eb29344ad6edac59c94f71974c950f1cf50b99d060::gfd {
    struct GFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFD>(arg0, 9, b"GFD", b"GGK", b"Flyby is a mistake ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/730ccf25-66c8-4197-8d7b-ca621d580bfd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

