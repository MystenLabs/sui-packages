module 0xf6671981a99aa82e24d3bc84173401addae76ce68dc248099d7953576263f7d::sat_usd {
    struct SAT_USD has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: SAT_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT_USD>(arg0, decimals(), b"satUSD", b"Satoshi Stablecoin V2", b"https://river.inc/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicr4yz527zx7azjkccvx6eltuambpwxvarau3sjugyectfyjxb354")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT_USD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAT_USD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

