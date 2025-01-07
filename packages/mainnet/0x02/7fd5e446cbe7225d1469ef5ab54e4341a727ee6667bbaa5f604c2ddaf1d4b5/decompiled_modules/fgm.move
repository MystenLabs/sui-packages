module 0x27fd5e446cbe7225d1469ef5ab54e4341a727ee6667bbaa5f604c2ddaf1d4b5::fgm {
    struct FGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGM>(arg0, 6, b"FGM", b"Feels Good Man", b"$FGM - My Pepe philosophy is simple: Feels Good Man. It is based on the meaning of the word Pepe : 'To Go Pepe' - Matt Furie ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/combined_image_new2_7956753888.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

