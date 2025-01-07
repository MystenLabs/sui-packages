module 0x52bf122b98dd46b571fc2f93f30249a9e06f6bf20967661b063e0369577186e2::poon {
    struct POON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POON>(arg0, 6, b"POON", b"PoonOnaSui", b"Moon the poon am meme coinon sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000197_8b4b83e5f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POON>>(v1);
    }

    // decompiled from Move bytecode v6
}

