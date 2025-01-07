module 0x87d94eb068119b1623d12614e377c020e0b919c3cd74abe3e7aec96d0cce0cec::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"HopDino", x"5752414141414141414820f09fa696", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955976187.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

