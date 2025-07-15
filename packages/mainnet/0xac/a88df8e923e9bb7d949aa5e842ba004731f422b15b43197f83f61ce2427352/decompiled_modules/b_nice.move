module 0xaca88df8e923e9bb7d949aa5e842ba004731f422b15b43197f83f61ce2427352::b_nice {
    struct B_NICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NICE>(arg0, 9, b"bNICE", b"bToken NICE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

