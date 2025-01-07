module 0x86b2ffa46f30172d2de110b790200222f74e6b461ebaee4e26bd50dca206adfe::djbd {
    struct DJBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJBD>(arg0, 9, b"DJBD", b"Wewe", b"Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6021334-718f-4315-a8ea-3fe690c861ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

