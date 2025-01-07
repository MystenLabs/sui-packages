module 0xe494931d72e5a923fa00f0be9cefafcacb1e0e3f340722f473bab376a2492bef::meowz {
    struct MEOWZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWZ>(arg0, 6, b"MEOWZ", b"MEOW ZILLA", b"Created by the greatest samurai cat and the giant monster Godzilla.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_7692d2b40c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

