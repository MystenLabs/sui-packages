module 0x6fed8756815f27dca1567d068dcd272ce21acc95d51dedd5eab3c0e411811530::catdog {
    struct CATDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDOG>(arg0, 6, b"Catdog", b"CatDog", b"sui catdog Scatdog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725005129779_a3502096a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

