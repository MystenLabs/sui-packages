module 0xe4f771ddb7196f5945d4e413bd4df05ecf64c2c7316b7d55b251ec87475c4e61::sgladiator {
    struct SGLADIATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGLADIATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGLADIATOR>(arg0, 6, b"Sgladiator", b"Gladiator on Sui", b"Gladiator on Sui - movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asfsfasfsfa_8ee9db9b20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGLADIATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGLADIATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

