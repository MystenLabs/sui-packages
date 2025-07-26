module 0x8b0ffa828ccd0d41ad97b6c693bb49c2c39cd0d90579c22c4b973270c4faeb9a::b_sudo {
    struct B_SUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUDO>(arg0, 9, b"bSUDO", b"bToken SUDO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

