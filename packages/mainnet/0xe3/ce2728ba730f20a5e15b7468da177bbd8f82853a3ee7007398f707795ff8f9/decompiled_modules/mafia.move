module 0xe3ce2728ba730f20a5e15b7468da177bbd8f82853a3ee7007398f707795ff8f9::mafia {
    struct MAFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAFIA>(arg0, 6, b"MAFIA", b"Sui Mafia", x"54686520626f7373206f66207468652053756920756e646572776f726c642c20244d414649412072756e73207468652073686f772e204a6f696e207468652066616d696c792c2072697365207468726f756768207468652072616e6b732c20616e6420706c617920627920796f7572206f776e2072756c65732e204c6f79616c74792069732065766572797468696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_5ffc818964.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAFIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

