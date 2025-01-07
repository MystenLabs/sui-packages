module 0x3a14c4938d113c31063989e8e1ec576a4c2ce5483845f17e08021b7d9a0f09d9::ares {
    struct ARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARES>(arg0, 6, b"ARES", b"The Cat of War", b"The god of war has taken the form of a cat with every single weapon imaginable to mankind and sol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ARES_d657663650.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARES>>(v1);
    }

    // decompiled from Move bytecode v6
}

