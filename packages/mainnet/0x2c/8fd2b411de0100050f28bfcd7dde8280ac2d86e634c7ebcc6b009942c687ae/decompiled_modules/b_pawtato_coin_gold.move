module 0x2c8fd2b411de0100050f28bfcd7dde8280ac2d86e634c7ebcc6b009942c687ae::b_pawtato_coin_gold {
    struct B_PAWTATO_COIN_GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAWTATO_COIN_GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAWTATO_COIN_GOLD>(arg0, 9, b"bGOLD", b"bToken GOLD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAWTATO_COIN_GOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAWTATO_COIN_GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

