module 0xaf562595ba00c26af4def2c5013d979ac3e50b88134fcf2955ed675d34c96c80::trio {
    struct TRIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIO>(arg0, 6, b"TRIO", b"MetaTrio", b"MetaTrio isnt just a coin; its a celebration of the three biggest legends that shaped the crypto meme culture: PNUT, Doge, and Pepe. Each brings its unique story, energy, and community, now united in a project that promises to revolutionize the digital meme world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000306826_c35d033db3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

