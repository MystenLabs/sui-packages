module 0x422e4bd74911497d3c9c37432b2bf29545345da8d30f50355a0c9946f0f6a282::hh {
    struct HH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HH>(arg0, 9, b"HH", b"Huha", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acd58c22-6669-405e-a7ce-19d585f321e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HH>>(v1);
    }

    // decompiled from Move bytecode v6
}

