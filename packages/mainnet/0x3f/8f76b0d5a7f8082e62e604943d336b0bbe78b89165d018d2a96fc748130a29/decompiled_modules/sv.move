module 0x3f8f76b0d5a7f8082e62e604943d336b0bbe78b89165d018d2a96fc748130a29::sv {
    struct SV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SV>(arg0, 9, b"SV", b"Shiva", b"Shiva god", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5aac6324-44bb-4c40-8b35-74d62c3629b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SV>>(v1);
    }

    // decompiled from Move bytecode v6
}

