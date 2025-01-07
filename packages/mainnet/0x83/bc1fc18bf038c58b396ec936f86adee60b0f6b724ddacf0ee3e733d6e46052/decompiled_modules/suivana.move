module 0x83bc1fc18bf038c58b396ec936f86adee60b0f6b724ddacf0ee3e733d6e46052::suivana {
    struct SUIVANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVANA>(arg0, 6, b"SUIVANA", b"VANA", b"Vana is an AI identity generation application that allows users to create a digital avatar and can be used in different applications, while the avatar is private and can only be controlled by the user who created it and the account they authorize.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_U_Jka_TXV_400x400_ccfa2f0694.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

