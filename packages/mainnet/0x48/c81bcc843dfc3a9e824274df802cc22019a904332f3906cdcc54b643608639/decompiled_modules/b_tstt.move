module 0x48c81bcc843dfc3a9e824274df802cc22019a904332f3906cdcc54b643608639::b_tstt {
    struct B_TSTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TSTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TSTT>(arg0, 9, b"bTSTT", b"bToken TSTT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TSTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TSTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

