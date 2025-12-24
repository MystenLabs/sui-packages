module 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyleg {
    struct XYLEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYLEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<XYLEG>(arg0, 9, 0x1::string::utf8(b"XYLE-G"), 0x1::string::utf8(b"XYLE Governance Token"), 0x1::string::utf8(b"Fixed-supply governance token for XYLE Protocol DAO."), 0x1::string::utf8(b"https://raw.githubusercontent.com/dappstertools-coder/xyle-token-assets/main/xyleg.png"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<XYLEG>>(0x2::coin::mint<XYLEG>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYLEG>>(v2, @0x0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<XYLEG>>(0x2::coin_registry::finalize<XYLEG>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

