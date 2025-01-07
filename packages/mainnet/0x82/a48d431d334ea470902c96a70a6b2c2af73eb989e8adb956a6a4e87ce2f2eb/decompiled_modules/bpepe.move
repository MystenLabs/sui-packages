module 0x82a48d431d334ea470902c96a70a6b2c2af73eb989e8adb956a6a4e87ce2f2eb::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPEPE>(arg0, 6, b"BPEPE", b"BLUE PEPE", b"The ultimate meme frog just went full degen, now rocking that icy blue drip on Sui. this aint your regular Pepe, its Blue Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/strong_snek_68fecb6499b5810d8d61_3cabc3195d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

