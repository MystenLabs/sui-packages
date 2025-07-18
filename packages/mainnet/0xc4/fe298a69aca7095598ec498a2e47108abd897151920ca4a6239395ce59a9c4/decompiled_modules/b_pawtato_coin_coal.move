module 0xc4fe298a69aca7095598ec498a2e47108abd897151920ca4a6239395ce59a9c4::b_pawtato_coin_coal {
    struct B_PAWTATO_COIN_COAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_COAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_COAL>(arg0, 9, b"bCOAL", b"bToken COAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_COAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_COAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

