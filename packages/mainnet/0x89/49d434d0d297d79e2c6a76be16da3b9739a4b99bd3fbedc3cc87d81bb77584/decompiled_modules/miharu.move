module 0x8949d434d0d297d79e2c6a76be16da3b9739a4b99bd3fbedc3cc87d81bb77584::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHARU>(arg0, 6, b"MIHARU", b"miharu", b"Smiling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241113_213443_467572a1f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

