module 0x88d268c9a4aa4aedebe27eaa42da0d2ae8fbcbbbe9be62821cf839cb8ec7da7c::atom {
    struct ATOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATOM>(arg0, 9, b"ATOM", b"meme", b"comos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3efd4841a14b7e30bd9921b7d1bcba4eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

