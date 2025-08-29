module 0x22d09eb4200d7844cc9d880c3338bb50a34fd8c9cf8994bd99a9be8355cdfe5::stgfish {
    struct STGFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STGFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STGFISH>(arg0, 6, b"STGFISH", b"Stg-Fish", b"Stagging token for Fishtasy - gamefi on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigcv7wwkidc2c6c2fysgk6zmfr75vumysa2gsft5rjsqxb6t3bnqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STGFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STGFISH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

