module 0x4f706dfdcbc5dea7ac884132ed4dc76c42029465714554a2bf18c23512dc5453::ppg {
    struct PPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPG>(arg0, 9, b"PPG", b"painting", b"Full of art and creativity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bf2aab4-36bc-49dc-bf75-d5b50e0f26d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

