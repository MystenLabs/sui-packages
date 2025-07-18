module 0x833579aa05b2c64a04446ebe184060328dcce07043e8b8d56bee117d899372f8::b_pawtato_coin_crystal {
    struct B_PAWTATO_COIN_CRYSTAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_CRYSTAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_CRYSTAL>(arg0, 9, b"bCRYSTAL", b"bToken CRYSTAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_CRYSTAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_CRYSTAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

