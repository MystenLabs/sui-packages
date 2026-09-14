module 0xa2e5468133b46ba94b17da12e6575da2925774327403f9699692f3fa7d1a5f52::tcc {
    struct TCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TCC>(arg0, 9, 0x1::string::utf8(b"TCC"), 0x1::string::utf8(b"TRADING CARD COIN"), 0x1::string::utf8(b"Trading Card Coin on Sui"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeiatc3oacafypyt4csrnxqtufwvpdmpyutqkroi56tke6ssqkt3sly"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TCC>>(0x2::coin_registry::finalize<TCC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

