module 0x858ccbd15d231c041a828ecee1f728af8a76b298b80d137b519567161ca12806::suiky {
    struct SUIKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKY>(arg0, 6, b"SUIKY", b"Suiky", b"cute & quacky - Suiky is the new quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4134_06aa3133d6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

