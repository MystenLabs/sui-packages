module 0x73c6d6f5e2930b12c542db2bb1fde99f5cfd1e74f7d69063a5d59a890b196c79::groke {
    struct GROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROKE>(arg0, 6, b"GROKE", b"The GROKE", b"Groke is a longly penguin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigjmmvzzm7sssgfyya4sfgwhwmg4dsu6axeb7ntbfiapunil7risu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GROKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

