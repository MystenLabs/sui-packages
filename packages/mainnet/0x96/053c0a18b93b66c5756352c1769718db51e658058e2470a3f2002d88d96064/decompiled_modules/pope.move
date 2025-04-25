module 0x96053c0a18b93b66c5756352c1769718db51e658058e2470a3f2002d88d96064::pope {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 6, b"POPE", b"POPE FUNERAL", b"Funeral services for Pope Francis will be held in Rome this Saturday. President Trump will be attending, along with other World leaders!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid3bie3buujw2aj7p5m5ahk572hzixofjcfdokv66p2q365n2alxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

