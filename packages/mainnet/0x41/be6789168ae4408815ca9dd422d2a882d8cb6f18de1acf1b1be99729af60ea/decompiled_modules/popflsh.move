module 0x41be6789168ae4408815ca9dd422d2a882d8cb6f18de1acf1b1be99729af60ea::popflsh {
    struct POPFLSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFLSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFLSH>(arg0, 6, b"Popflsh", b"POPFISH", x"496e2074686520646570746873206f662074686520626c6f636b636861696e207365612c0a5377696d73206120746f6b656e2c2077696c6420616e6420667265652c0a506f4669736820697320697473206e616d652c206f6820736f206772616e642c0a5769746820612063757465206c6974746c65206d6f7574682c2069742074616b65732061207374616e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdadasdqweqweqeqeqeqeqe_36e0eb0676.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFLSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPFLSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

