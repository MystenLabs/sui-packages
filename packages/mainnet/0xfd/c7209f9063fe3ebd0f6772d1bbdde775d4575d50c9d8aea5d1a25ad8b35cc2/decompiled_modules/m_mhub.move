module 0xfdc7209f9063fe3ebd0f6772d1bbdde775d4575d50c9d8aea5d1a25ad8b35cc2::m_mhub {
    struct M_MHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_MHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_MHUB>(arg0, 9, b"M_MHUB", b"MASNAU", b"The mmhub is mentable coin in MASNAU airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cda3e39f-2d7d-4c63-b9c3-2cfd262153ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_MHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_MHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

