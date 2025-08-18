module 0x9be11a58171759267a34976cc75c226813299e76c25910ecac5b11f094bd1dd7::b_buy {
    struct B_BUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BUY>(arg0, 9, b"bBUY", b"bToken BUY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

