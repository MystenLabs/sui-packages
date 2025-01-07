module 0xfee020a09c2321ee2317f462ed045898d0a9cf1d2dcdedc454726c27ad8af3ab::roto {
    struct ROTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROTO>(arg0, 9, b"Roto", b"Roto", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROTO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

