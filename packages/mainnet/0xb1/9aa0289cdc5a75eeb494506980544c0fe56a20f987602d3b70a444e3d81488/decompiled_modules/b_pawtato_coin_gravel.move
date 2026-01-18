module 0xb19aa0289cdc5a75eeb494506980544c0fe56a20f987602d3b70a444e3d81488::b_pawtato_coin_gravel {
    struct B_PAWTATO_COIN_GRAVEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_GRAVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_GRAVEL>(arg0, 9, b"bGRAVEL", b"bToken GRAVEL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_GRAVEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_GRAVEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

