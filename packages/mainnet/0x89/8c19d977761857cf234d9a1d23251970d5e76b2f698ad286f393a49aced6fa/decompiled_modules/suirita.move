module 0x898c19d977761857cf234d9a1d23251970d5e76b2f698ad286f393a49aced6fa::suirita {
    struct SUIRITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRITA>(arg0, 6, b"SUIRITA", b"Chikorita on Sui Game", b"Build the Pokemon Ponzi game world on Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiae4ahjcllnjttx2h7aqu2mket2c2cby5wrzge6nqbbqzhjsyzukq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRITA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

