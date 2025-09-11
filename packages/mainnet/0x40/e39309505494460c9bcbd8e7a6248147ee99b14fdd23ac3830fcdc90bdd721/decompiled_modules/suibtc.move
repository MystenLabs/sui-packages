module 0x40e39309505494460c9bcbd8e7a6248147ee99b14fdd23ac3830fcdc90bdd721::suibtc {
    struct SUIBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBTC>(arg0, 6, b"SUIBTC", b"SuiBitcoin", b"BlueSuiBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieumkpll2vrijd6vzyf5owwzw2vdlowelx2ihurw52mcbqzjh7qd4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

