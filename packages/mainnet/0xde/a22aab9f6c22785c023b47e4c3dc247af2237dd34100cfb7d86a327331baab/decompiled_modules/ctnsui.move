module 0xdea22aab9f6c22785c023b47e4c3dc247af2237dd34100cfb7d86a327331baab::ctnsui {
    struct CTNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTNSUI>(arg0, 6, b"CTNSUI", b"CATANA", b"Catana is a community driven meme token on solana blockchain . Inspired by the internet favorite feline friends , Catana aims to bring smile to your face and a purr to you wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1732301276098_8ed77670d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

