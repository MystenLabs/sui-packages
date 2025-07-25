module 0xc16648b6328fea19587107012c9dd0290397d0def2fd2cb98779f9c5d1e2283a::adsada {
    struct ADSADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADSADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADSADA>(arg0, 6, b"Adsada", b"dadas", x"6173646173546865204f726967696e616c204f6e652c2063726561746f72206f662074686520506f6bc3a96d6f6e20756e6976657273652c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidfbxlv5xbacxn3zxdlwiymr7lhlwdzcfjbcdiodktz5hqac7lasm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADSADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADSADA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

