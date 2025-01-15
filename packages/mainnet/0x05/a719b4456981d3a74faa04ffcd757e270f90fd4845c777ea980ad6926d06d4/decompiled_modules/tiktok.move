module 0x5a719b4456981d3a74faa04ffcd757e270f90fd4845c777ea980ad6926d06d4::tiktok {
    struct TIKTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKTOK>(arg0, 9, b"TIKTOK", b"ElonTiktok", b"Rumors are swirling that Elon Musk might acquire TikTok, a move that could significantly reshape the social media landscape.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bfbce56-e975-43af-a4c8-f0f42673934f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKTOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKTOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

