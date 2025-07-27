module 0xd04a4c322d11397f76fa29312cf8c233346e3c50a69697ceb7d98a816f7fec94::uranus {
    struct URANUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: URANUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URANUS>(arg0, 9, b"URANUS", b"Uranus", b"Website: https://jup.ag/studio/BFgdzMkTPdKKJeTipv2njtDEwhKxkgFueJQfJGt1jups", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-create.jup.ag/images/BFgdzMkTPdKKJeTipv2njtDEwhKxkgFueJQfJGt1jups-5454b0c3-de78-481d-89e1-7b950f4da11a.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<URANUS>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URANUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URANUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

