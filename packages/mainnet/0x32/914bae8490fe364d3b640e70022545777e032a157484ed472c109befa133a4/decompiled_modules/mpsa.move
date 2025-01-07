module 0x32914bae8490fe364d3b640e70022545777e032a157484ed472c109befa133a4::mpsa {
    struct MPSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPSA>(arg0, 6, b"MPSA", b"Make Pets Safe Again", b"Welcome to MPSA, the meme with a heart for our furry friends! Inspired by the love and care we share for pets, MPSA is a playful yet impactful meme designed to spread awareness about pet safety. While we embrace the fun and humor of meme culture, our mission is to support a community that cares deeply for animals and their well-being.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_I_de_ecran_din_2024_10_01_la_19_36_37_b43b6f6c2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

