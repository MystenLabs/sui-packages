module 0x6383c6333b4b5005dbf4ac416c26a08bb16eaf6bda7206f9d73ccf7d0ab9bd0b::ggt {
    struct GGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGT>(arg0, 9, b"GGT", b"Gogeta", b"GOGETA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e8fbbb1-c992-4506-ad74-71011f2f0b48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

