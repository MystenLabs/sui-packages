module 0x685a2152ee5927c0e4aec4d56b55b30f003ffcbb0836dcc42a1e3e12a055d04a::b_jui {
    struct B_JUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_JUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_JUI>(arg0, 9, b"bJUI", b"bToken JUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_JUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_JUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

