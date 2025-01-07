module 0x1d673dbe9966de86bf7662f5f5a66f1138f8837427ceecf7ce8a6238fb557ba1::dog_mask {
    struct DOG_MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_MASK>(arg0, 9, b"DOG_MASK", b"Dogwifmask", b"Just a dog with mask ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4168c3ad-361e-4d06-8b1f-ba55b2c60ae3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_MASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

