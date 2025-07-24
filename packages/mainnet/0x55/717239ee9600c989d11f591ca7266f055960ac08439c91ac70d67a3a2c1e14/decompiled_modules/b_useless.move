module 0x55717239ee9600c989d11f591ca7266f055960ac08439c91ac70d67a3a2c1e14::b_useless {
    struct B_USELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_USELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_USELESS>(arg0, 9, b"bUSELESS", b"bToken USELESS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_USELESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_USELESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

