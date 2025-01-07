module 0x4f2579c664c1a23e3816709f5bf4ee3ad8e66ab80a004ea7abecea0bc97e4993::shoko {
    struct SHOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOKO>(arg0, 6, b"SHOKO", b"Shoko", b"KABOSU NEW DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2222_0e68414dbc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

