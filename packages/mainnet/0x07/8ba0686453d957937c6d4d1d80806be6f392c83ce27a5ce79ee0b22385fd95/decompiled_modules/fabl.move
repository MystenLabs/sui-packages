module 0x78ba0686453d957937c6d4d1d80806be6f392c83ce27a5ce79ee0b22385fd95::fabl {
    struct FABL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FABL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FABL>(arg0, 6, b"FABL", b"Fables On Sui", b"Welcome to Fable Haven, the home of the Fables and the FABL token, a meme coin built on the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018324_c61759e080.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FABL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FABL>>(v1);
    }

    // decompiled from Move bytecode v6
}

