module 0x12f77e0941097ee70ff4c8b6628a84b64af84aabc933eca272dc2e7ec872d0f1::suiora {
    struct SUIORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIORA>(arg0, 6, b"SUIORA", b"Zeraora Pokecombat", b"$SUIORA Building the first battle-to-earn Pokemon game on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmp65os6shqbjz43jx65mlono5ulmpmc3hj2jzms2rjftqmmvaw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIORA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

