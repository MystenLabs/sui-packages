module 0xd0589a61893828285f392f80b2ed31ce4078d0e5cc70ddaf79ee1a23039410c::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 2, b"POPO", b"Popo", b"POPO dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://e7.pngegg.com/pngimages/477/852/png-clipart-puppy-face-siberian-husky-bulldog-weimaraner-puppy-face-animals.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPO>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

