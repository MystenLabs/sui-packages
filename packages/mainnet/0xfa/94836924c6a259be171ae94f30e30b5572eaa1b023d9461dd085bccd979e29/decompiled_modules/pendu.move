module 0xfa94836924c6a259be171ae94f30e30b5572eaa1b023d9461dd085bccd979e29::pendu {
    struct PENDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENDU>(arg0, 6, b"PENDU", b"PENDU Coin", b"Bara Its me, Pendu.. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005921_e43ba51896.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

