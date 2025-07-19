module 0x336313b220e5ec45325469123868f0d26cb564c175e419b5bb1c08bab8a626be::st {
    struct ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST>(arg0, 6, b"ST", b"SUI TAPPER", b"Sui Tapper is a Web3 clicker game built on the Sui blockchain, combining addictive tap-based gameplay with real crypto rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiea7m3pmhckuneh2mlb3k335srqwa23h4hz6hswlup2wmj4mws6pq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

