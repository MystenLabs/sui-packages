module 0x346033a428aef34a32f72d12f0827a83ae9c68e4e52cec570bf5de701aa5c6b6::b_pump {
    struct B_PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PUMP>(arg0, 9, b"bPUMP", b"bToken PUMP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

