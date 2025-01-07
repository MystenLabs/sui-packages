module 0xa4081389225807110a18d76f4cabd268b2f593c4261e7f0fe5260ffe9cda2668::lostpepe {
    struct LOSTPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSTPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSTPEPE>(arg0, 6, b"LOSTPEPE", b"Sui The LostPepe", b"LostPepe is a meme coin inspired by the famous Pepe the Frog, representing the journey of being lost in the vast crypto jungle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hg_Gep_Zps_400x400_a8d43bcf72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSTPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOSTPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

