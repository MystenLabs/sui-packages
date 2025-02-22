module 0xccb1d9dc68274a36ecc2e1832290f60e84a377f9945ca5e39fbc827ec18de3bc::ak {
    struct AK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AK>(arg0, 6, b"AK", b"AKAI", b"AKAI is an AI Agent that helps you explore deep into the global AI technology scene!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/34a07800-f57e-4111-b395-4c5ede0d2d1e.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

