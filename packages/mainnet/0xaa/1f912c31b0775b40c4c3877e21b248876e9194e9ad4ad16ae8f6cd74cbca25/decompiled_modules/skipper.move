module 0xaa1f912c31b0775b40c4c3877e21b248876e9194e9ad4ad16ae8f6cd74cbca25::skipper {
    struct SKIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIPPER>(arg0, 9, b"SKIPPER", b"Skipper", b"Skipper the Penguin From Penguins of Madagascar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf8272d1-731b-4851-9d5a-98893903c0a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKIPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

