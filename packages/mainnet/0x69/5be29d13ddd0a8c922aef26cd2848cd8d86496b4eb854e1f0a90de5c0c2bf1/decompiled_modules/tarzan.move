module 0x695be29d13ddd0a8c922aef26cd2848cd8d86496b4eb854e1f0a90de5c0c2bf1::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"symbol", b"token name", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

