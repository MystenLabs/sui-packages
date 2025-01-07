module 0xcffe91e5f3997c1445e4c7453a569d9f04cd2edaa076b15c8ab7e334985716e0::seals {
    struct SEALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALS>(arg0, 6, b"Seals", b"Kidnapped Seals", b"Kidnapped Seals Meme Token is a playful and satirical cryptocurrency designed to raise awareness for wildlife conservation, particularly focusing on seal protection. The token leverages humor and viral meme culture to engage a community of supporters, promoting discussions around environmental issues", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12702_329d8073eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

