module 0x704f3708d3b4de77e22f639fde260cffac547aa386d1781de8b4a422a27af7e3::depressedk {
    struct DEPRESSEDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPRESSEDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPRESSEDK>(arg0, 9, b"DEPRESSEDK", b"DKID", b"Depressed Kid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b890775d-be32-42f0-ad1d-ab2f6e877d6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPRESSEDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPRESSEDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

