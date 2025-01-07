module 0xc279eec43f69079c1ad614edd240cfc4c500f2c3a07aa49ce30fa8f5dcf89e9::paralym {
    struct PARALYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARALYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARALYM>(arg0, 6, b"PARALYM", b"PARALYMPICS", b"THE PARALYMPIC GAMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PARA_ba794aad48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARALYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARALYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

