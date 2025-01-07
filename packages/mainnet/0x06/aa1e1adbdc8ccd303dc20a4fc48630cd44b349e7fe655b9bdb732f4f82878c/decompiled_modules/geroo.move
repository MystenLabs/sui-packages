module 0x6aa1e1adbdc8ccd303dc20a4fc48630cd44b349e7fe655b9bdb732f4f82878c::geroo {
    struct GEROO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEROO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEROO>(arg0, 6, b"GEROO", b"The Lazy Cat", b"Geroo is the lazy cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/recommend-works/png-clipart/20240519/ourmid/pngtree-cute-happy-cat-meme-sticker-tshirt-illustration-png-image_12491240.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GEROO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEROO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEROO>>(v1);
    }

    // decompiled from Move bytecode v6
}

