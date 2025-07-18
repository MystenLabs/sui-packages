module 0x12ca2cd35f086c1f9ae508f9d4a3ce3299aa103d693d76b3fa7a15925993dc9::b_pawtato_coin_wood {
    struct B_PAWTATO_COIN_WOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_WOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_WOOD>(arg0, 9, b"bWOOD", b"bToken WOOD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_WOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_WOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

