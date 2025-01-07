module 0xce67c2bb277f45e7c085cef33d7ae8b64818ead0473b721cfb92cb6ed5b637b4::dog_mask {
    struct DOG_MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_MASK>(arg0, 9, b"DOG_MASK", b"Dogwifmask", b"Just a dog with mask ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab08a08d-22ae-4f59-8221-e185c8d15af2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_MASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

