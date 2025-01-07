module 0xa1b8bc4c4c8a35c58730da5eaaac59bf72ae4e1fb324e0d5ac047cc96342665d::owlcat {
    struct OWLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLCAT>(arg0, 6, b"OWLCAT", b"OwlCat", b"OwlCat is not a Cat, nor an Owl, he is an OwlCat, so don't be rude calling him cat or owl, join the community and spread the word!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_3_2702a268ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWLCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

