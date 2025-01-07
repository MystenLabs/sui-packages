module 0xebf30bb5bd2a8c8c4a31b91b53ce6b49d8c7d2a748e6d676fc84a1eb33fdf4f5::gfish {
    struct GFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFISH>(arg0, 6, b"GFISH", b"GOLDENFISH", b"GOOLDENFISH is a meme surrounded by luck and good vibez only. This not ordinary aquarium dweller, its the golden ruler of memes that will lead the digital ocean and bring luck to its all hodlers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3903_53342f9c0a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

