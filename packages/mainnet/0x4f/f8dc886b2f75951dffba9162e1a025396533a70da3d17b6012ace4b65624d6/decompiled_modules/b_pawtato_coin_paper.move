module 0x4ff8dc886b2f75951dffba9162e1a025396533a70da3d17b6012ace4b65624d6::b_pawtato_coin_paper {
    struct B_PAWTATO_COIN_PAPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_PAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_PAPER>(arg0, 9, b"bPAPER", b"bToken PAPER", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_PAPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_PAPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

