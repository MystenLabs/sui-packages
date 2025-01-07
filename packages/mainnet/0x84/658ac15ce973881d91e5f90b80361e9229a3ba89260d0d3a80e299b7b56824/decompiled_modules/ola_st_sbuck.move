module 0x84658ac15ce973881d91e5f90b80361e9229a3ba89260d0d3a80e299b7b56824::ola_st_sbuck {
    struct OLA_ST_SBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLA_ST_SBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLA_ST_SBUCK>(arg0, 9, b"OST_SBUCK", b"Ola SBUCK Vault", b"yield bearing sBUCK collect the rewards from different strategies created by OlaWealth Platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdreMM3bcMJRyjGxJRcZWfMnferu66eLJP9cnu37QqjWU")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLA_ST_SBUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLA_ST_SBUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

