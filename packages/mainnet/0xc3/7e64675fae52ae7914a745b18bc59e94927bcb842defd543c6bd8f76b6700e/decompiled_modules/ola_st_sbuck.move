module 0xc37e64675fae52ae7914a745b18bc59e94927bcb842defd543c6bd8f76b6700e::ola_st_sbuck {
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

