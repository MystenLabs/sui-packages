module 0x70a3eb9b966f2be037186793e3ac0eed36311c7c134fe8c743c18ecb514f2273::yuki {
    struct YUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKI>(arg0, 6, b"YUKI", b"YUKISUI", b"Yuki new agent ai on Suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidal64o7bo7ejwzdd6bgljvja7lkanezx2iillwnyfu6pbkth55da")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YUKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

