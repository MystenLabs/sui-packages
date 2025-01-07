module 0xf7faca5af6e703fad48c680e30fb253524197f44f587f5dcbf7c64ab439c2d0::peepee {
    struct PEEPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPEE>(arg0, 6, b"PEEPEE", b"Pee Pee", b"Introducing Pee Pee (PEEPEE): the most Degen, based meme coin out there. Forget playing it safe - PEEPEE comes strapped with \"big dick energy\" and isn't here to make friends, it's here to make waves. A green, unapologetic take on Pepe, this coin is for the true Degen's who don't flinch at a wild ride and know how to have fun while sending it to the moon. If you're tired of the same old safe plays, grab your PEEPEE, flex hard, and let's break the crypto space one meme at a time. Its bold, its reckless - its the PEEPEE way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Fysa8_C_Ue_Kb_Med_L_8011ac9a33.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

