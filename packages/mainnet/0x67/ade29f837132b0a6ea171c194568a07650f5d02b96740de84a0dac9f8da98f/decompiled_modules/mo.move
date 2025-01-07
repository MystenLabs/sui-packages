module 0x67ade29f837132b0a6ea171c194568a07650f5d02b96740de84a0dac9f8da98f::mo {
    struct MO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MO>(arg0, 9, b"MO", b"Moo", b"Moooo mooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/859559d8-8926-4e95-b395-e1c54b101aad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MO>>(v1);
    }

    // decompiled from Move bytecode v6
}

