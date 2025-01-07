module 0xb6696665a139fdbed0c9ba8c275b35bfd01a9045608268b6d88c9878d18b5226::auva {
    struct AUVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUVA>(arg0, 6, b"AUVA", b"SUI AUVA", b"Say hello to AUVA, our friendly AI companion built on the Solana ecosystem to bring together the best of decentralized utilities and Meme-Inspired Culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/auva_d15c46db9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

