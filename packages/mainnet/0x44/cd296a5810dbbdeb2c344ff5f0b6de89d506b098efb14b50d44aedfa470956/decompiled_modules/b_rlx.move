module 0x44cd296a5810dbbdeb2c344ff5f0b6de89d506b098efb14b50d44aedfa470956::b_rlx {
    struct B_RLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_RLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_RLX>(arg0, 9, b"bRLX", b"bToken RLX", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_RLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_RLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

