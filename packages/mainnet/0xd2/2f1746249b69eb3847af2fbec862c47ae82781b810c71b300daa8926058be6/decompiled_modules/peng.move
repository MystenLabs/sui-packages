module 0xd22f1746249b69eb3847af2fbec862c47ae82781b810c71b300daa8926058be6::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"PENG", b"PENGSUIN", b" $PENG | PENGSUIN: The most exciting memecoin on the SUI blockchain!  Join the penguin-powered revolution as we ride the waves of fun, community, and endless possibilities. With a strong community focus, $PENG brings the chill vibes of crypto to the next level.  Ready to make your move in the penguin world? Let's make a splash together! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U3b4_Aa_X_400x400_66f91008fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

