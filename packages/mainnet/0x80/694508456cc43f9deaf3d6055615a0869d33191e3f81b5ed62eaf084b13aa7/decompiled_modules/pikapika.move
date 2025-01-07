module 0x80694508456cc43f9deaf3d6055615a0869d33191e3f81b5ed62eaf084b13aa7::pikapika {
    struct PIKAPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKAPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKAPIKA>(arg0, 6, b"PIKAPIKA", b"PikaSui", b"PikaSui was a lightning-fast creature made of pure energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_00_57_42_038c89176c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKAPIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKAPIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

