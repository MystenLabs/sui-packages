module 0x42bfb88eb17cfc74a723d02b19900e44882abedbff64cdd4b201048e515eeb72::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 6, b"Oggy", b"OGGY INU", b"\"Unleash the power of community and creativity with OGGY INU  where every bark echoes in the blockchain!\"  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8964_07a0bfd8c1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

