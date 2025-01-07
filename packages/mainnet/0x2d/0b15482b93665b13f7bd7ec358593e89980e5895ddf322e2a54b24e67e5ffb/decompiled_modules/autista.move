module 0x2d0b15482b93665b13f7bd7ec358593e89980e5895ddf322e2a54b24e67e5ffb::autista {
    struct AUTISTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTISTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTISTA>(arg0, 6, b"AUTISTA", b"AUTISTA CAT COIN ON SUI", x"426f6f737420657665727964617920746f204465780a507265706169642044657820557064617465207768656e207265616368204b4f54530a45766572796f6e65206c6f76652041555449535441", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_17_17_36_19_c7e9045b5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTISTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTISTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

