module 0xf6a1aca7655d0a5f8fc79c7e05d3fe52c6350235ba80f0b7ef42aabb5af557c::wop {
    struct WOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOP>(arg0, 9, b"WOP", b"Pow", b"Test 123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd034ff8-eb0d-46b3-9280-32525abe3805.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

