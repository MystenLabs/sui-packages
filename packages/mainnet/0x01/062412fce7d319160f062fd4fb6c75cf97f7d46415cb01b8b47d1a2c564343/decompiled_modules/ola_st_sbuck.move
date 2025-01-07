module 0x1062412fce7d319160f062fd4fb6c75cf97f7d46415cb01b8b47d1a2c564343::ola_st_sbuck {
    struct OLA_ST_SBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLA_ST_SBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLA_ST_SBUCK>(arg0, 9, b"LP-sUSDC", b"sUSDC Staking Vault", b"Yield bearing sUSDC collects the rewards from auto-compounding strategies co-developed by OlaWealth & Bucket Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdreMM3bcMJRyjGxJRcZWfMnferu66eLJP9cnu37QqjWU")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLA_ST_SBUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLA_ST_SBUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

