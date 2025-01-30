module 0xc9c8c0f75d3041ea519f98caa8ef63b9d15ab2bda1bb7b35801a0843882a2db6::mnsl {
    struct MNSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNSL>(arg0, 9, b"MNSL", b"MonSoli", b"big lufe is big love enjoy from everything ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37ef53fc-fa21-4d42-8e31-522323021ff0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

