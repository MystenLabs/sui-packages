module 0xca39a1c229ba5b6e204aaeebc6dfb5b1dac1bce2dc23248c7c6c0808c66ea374::b_finn {
    struct B_FINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FINN>(arg0, 9, b"bFINN", b"bToken FINN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

