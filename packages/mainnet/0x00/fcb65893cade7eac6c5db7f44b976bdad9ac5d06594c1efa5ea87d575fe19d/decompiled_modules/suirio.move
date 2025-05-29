module 0xfcb65893cade7eac6c5db7f44b976bdad9ac5d06594c1efa5ea87d575fe19d::suirio {
    struct SUIRIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIO>(arg0, 6, b"SUIRIO", b"Riolu On Sui", b"Riolu On Sui is the first AI pokemon game on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreier2mn2nntr7bsncklxrhjyq55lyg4lessorsjpheffxvkxbpoy2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

