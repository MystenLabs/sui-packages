module 0xc3675b3c4934c0721df172cda6d9b473a38efbb8197e860c9d68f0079b8f691e::suiora {
    struct SUIORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIORA>(arg0, 6, b"SUIORA", b"Zeraora Pokecombat", b"Zeraora Pokecombat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmp65os6shqbjz43jx65mlono5ulmpmc3hj2jzms2rjftqmmvaw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIORA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

