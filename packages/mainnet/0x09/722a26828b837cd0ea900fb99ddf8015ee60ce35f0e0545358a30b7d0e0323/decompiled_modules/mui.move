module 0x9722a26828b837cd0ea900fb99ddf8015ee60ce35f0e0545358a30b7d0e0323::mui {
    struct MUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUI>(arg0, 9, b"MUI", b"Monkey sui", x"466f722043656c6562726174696f6e206f662057455745204c756e636820f09f8c8a20546865206e657874204c696665204368616e676572202e2e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed9145b8-7023-49ca-a254-a3e946f96e28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

