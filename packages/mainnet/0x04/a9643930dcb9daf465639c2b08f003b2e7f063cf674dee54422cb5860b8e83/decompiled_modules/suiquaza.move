module 0x4a9643930dcb9daf465639c2b08f003b2e7f063cf674dee54422cb5860b8e83::suiquaza {
    struct SUIQUAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQUAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQUAZA>(arg0, 6, b"SuiQuaza", b"SUIQUAZA THE SKY POKEMON LEGEND", b"$SuiQuaza The Sky Legend. The legendary Pokemon who rules the sky. Coming to the sea of $SUI to dominate and rule all the Pokemons whether on land or ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieiu434bcjwqxdimioveqstnpms3nc7enhczesgw6kscr2rqpuliy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQUAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIQUAZA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

