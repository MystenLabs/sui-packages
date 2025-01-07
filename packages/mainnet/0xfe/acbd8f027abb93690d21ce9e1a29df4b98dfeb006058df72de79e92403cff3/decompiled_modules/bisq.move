module 0xfeacbd8f027abb93690d21ce9e1a29df4b98dfeb006058df72de79e92403cff3::bisq {
    struct BISQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISQ>(arg0, 6, b"BISQ", b"BURNSQUID", b"just a tasty burn squid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004517_a3c21d41d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

