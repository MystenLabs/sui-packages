module 0x7940c449c61326269c1a5dfceb67689e0b7cd7c5e9e6e07efd2477e8fa06ff6f::b_pawtato_coin_stone {
    struct B_PAWTATO_COIN_STONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_STONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_STONE>(arg0, 9, b"bSTONE", b"bToken STONE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_STONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_STONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

