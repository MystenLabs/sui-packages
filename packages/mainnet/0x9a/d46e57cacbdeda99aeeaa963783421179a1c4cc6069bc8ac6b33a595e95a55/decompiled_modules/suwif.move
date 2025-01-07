module 0x9ad46e57cacbdeda99aeeaa963783421179a1c4cc6069bc8ac6b33a595e95a55::suwif {
    struct SUWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWIF>(arg0, 9, b"SUWIF", b"Suwifhat", b"Suiwifhat is sui most crazy meme, anticipated and hilarious.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUWIF>(&mut v2, 1300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

