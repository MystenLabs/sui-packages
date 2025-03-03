module 0xe34693a9809f0a0b8ec2b58ea6355b5f4ae7a5f7ae4a5ec31d9a8cfe4b5d3851::bitcoingames {
    struct BITCOINGAMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOINGAMES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BITCOINGAMES>(arg0, 6, b"BITCOINGAMES", b"Bitcoin games by SuiAI", b"Bitcoin games always paying on web3 with playstore games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bitcoin_game_ea9d4bbdbb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BITCOINGAMES>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOINGAMES>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

