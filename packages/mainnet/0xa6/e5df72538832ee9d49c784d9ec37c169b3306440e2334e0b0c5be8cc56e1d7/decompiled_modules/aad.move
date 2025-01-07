module 0xa6e5df72538832ee9d49c784d9ec37c169b3306440e2334e0b0c5be8cc56e1d7::aad {
    struct AAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAD>(arg0, 6, b"AAD", b"aaa dog", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_Qae_a_20240914114430_aef33b0af2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

