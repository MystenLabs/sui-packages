module 0x88c3faa5673f528afae978b055248cb4d04633e3c4dc27642bc032b3091a57b2::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 6, b"MABA", b"maba", b"Elon Musk Say on X to Make America Based Again, Now we create $MABA on Solana to supporting Trump for President. Elon Musk: Free speech is the bedrock of Democracy, and if people dont know whats going on, if they dont know the truth, how can they make an informed vote? You must have free speech in order to have Democracy. Thats why its the First Amendment, and the Second Amendment is there to ensure that we have the First Amendment President Trump must win to preserve the Constitution. He must win to preserve democracy in Americ,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_8_b11473d4d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

