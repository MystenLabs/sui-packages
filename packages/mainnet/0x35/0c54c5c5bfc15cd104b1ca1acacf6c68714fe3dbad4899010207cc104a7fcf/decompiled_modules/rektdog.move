module 0x350c54c5c5bfc15cd104b1ca1acacf6c68714fe3dbad4899010207cc104a7fcf::rektdog {
    struct REKTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKTDOG>(arg0, 9, b"REKTDOG", b"Rekt Dogi", b"All in and Rekt Like My dogi wooff !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d60f085-627f-486a-867e-9fcf135be8fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKTDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REKTDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

