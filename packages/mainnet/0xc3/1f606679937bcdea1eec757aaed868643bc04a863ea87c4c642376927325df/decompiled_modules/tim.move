module 0xc31f606679937bcdea1eec757aaed868643bc04a863ea87c4c642376927325df::tim {
    struct TIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIM>(arg0, 9, b"TIM", b"Mydog", b"16", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/541ee9ad-8f97-4816-bb63-3fd32a9ecb83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

