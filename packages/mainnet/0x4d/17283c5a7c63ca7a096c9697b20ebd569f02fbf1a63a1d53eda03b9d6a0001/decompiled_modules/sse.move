module 0x4d17283c5a7c63ca7a096c9697b20ebd569f02fbf1a63a1d53eda03b9d6a0001::sse {
    struct SSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSE>(arg0, 6, b"SSE", b"Sui Season", b"It's Sui Season.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Szn_1_f8ba908e71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

