module 0xe6c71159ca7c52c3d89b66949dbd5fe2bb99bd2b06689a871df104099c2835e0::jackass {
    struct JACKASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKASS>(arg0, 6, b"JACKASS", b"Sui Jackass", b"JACKASS was born one random day when someone forgot a trampoline in the middle of the metaverse. Small, white, and bursting with unstoppable energy, Trampy knew only one thing  to jump... and never stop! Each bounce made him stronger, happier, and more viral. Today, $TRAMPY is more than just a jump: it's a movement that celebrates craziness, hope, and the unstoppable energy of the crypto community. Are you ready to bounce with us? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hjkavn_e39e74f520.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

