module 0x20aabcb8c56aea2f29c1f807779542c9506b80d65a420080d196a13e9b1a5666::b_pawtato_coin_iron {
    struct B_PAWTATO_COIN_IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_IRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_IRON>(arg0, 9, b"bIRON", b"bToken IRON", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_IRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_IRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

