module 0x4e2b72dbafa087fef49b2d0c9e819637b4c4338039f4c96e9c966a79730cca57::bome {
    struct BOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 6, b"BOME", b"Book of Memes", b"The Book of memes on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_ceac2e35ac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

