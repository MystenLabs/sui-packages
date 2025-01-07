module 0x9490ed4df23f86d401e3b0481337e0c7469cb06183906a6096eb6b46c9460c14::ctcsui {
    struct CTCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTCSUI>(arg0, 6, b"CTCsui", b"Catana-comics", b"Catana is a community  driven meme token on the sui blockchain .Inspired by the internets favorite feline friends , catana aims to bring a smile to your face and a purr to your wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1732301276098_ef11337118.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

