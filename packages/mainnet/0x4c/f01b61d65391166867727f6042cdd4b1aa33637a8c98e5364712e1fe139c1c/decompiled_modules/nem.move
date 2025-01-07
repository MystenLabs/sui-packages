module 0x4cf01b61d65391166867727f6042cdd4b1aa33637a8c98e5364712e1fe139c1c::nem {
    struct NEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEM>(arg0, 9, b"NEM", b"Mai", b"Is", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2978df7-0fe1-464f-ae9b-a4df69fb1d74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

