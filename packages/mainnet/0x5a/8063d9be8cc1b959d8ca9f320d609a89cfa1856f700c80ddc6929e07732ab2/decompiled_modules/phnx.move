module 0x5a8063d9be8cc1b959d8ca9f320d609a89cfa1856f700c80ddc6929e07732ab2::phnx {
    struct PHNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHNX>(arg0, 9, b"PHNX", b"Phenix", b"Phenix is a limited edition NFT symbolizing rebirth and strength. Owning it unlocks access to exclusive art drops, a unique community, and future metaverse integrations. A must-have for collectors who believe in rising stronger from challenges", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b42b9dd-aa55-45ff-b23b-a4f7803ebee6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

