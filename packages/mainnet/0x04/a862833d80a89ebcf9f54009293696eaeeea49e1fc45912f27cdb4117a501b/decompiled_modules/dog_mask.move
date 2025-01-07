module 0x4a862833d80a89ebcf9f54009293696eaeeea49e1fc45912f27cdb4117a501b::dog_mask {
    struct DOG_MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_MASK>(arg0, 9, b"DOG_MASK", b"Dogwifmask", b"Just a dog with mask ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/faac9238-c4d6-4f4c-adcc-9f15ce599734.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_MASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

