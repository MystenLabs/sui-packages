module 0x33dcdc4dac545b0fd3d57cbc6744f4d0fdc8296e10a5f90f5cc15276c1b6b23b::weed {
    struct WEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEED>(arg0, 6, b"WEED", b"Weed on Sui", b"$WEED is the most laid-back token on the Sui blockchain. Its all about good vibes and chilling in the Sui ecosystem. Roll with $WEED and let the blockchain breeze carry you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Weed_09d0a13664.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

