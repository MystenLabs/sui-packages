module 0x13fd165a9a726c208b2566eb77e5ce09e8d2954d9c4e224d86953601bdbd2829::aped {
    struct APED has drop {
        dummy_field: bool,
    }

    fun init(arg0: APED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APED>(arg0, 6, b"APED", b"Aped", b"The classic community meme token made to bring glory to apes who aped $APED! Join our fast growing community! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S6r_J7r_Uc_400x400_4c6af888f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APED>>(v1);
    }

    // decompiled from Move bytecode v6
}

