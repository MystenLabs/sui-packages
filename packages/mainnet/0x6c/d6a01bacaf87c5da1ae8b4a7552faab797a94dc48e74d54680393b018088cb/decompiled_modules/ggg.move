module 0x6cd6a01bacaf87c5da1ae8b4a7552faab797a94dc48e74d54680393b018088cb::ggg {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGG>(arg0, 9, b"GGG", b"Hhgoy", b"Vvbn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0125138-9d7a-45a4-bd7b-f87a5e58f306.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

