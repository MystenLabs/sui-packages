module 0x2e4b32fb9d938ddad539f99449cd91bf4da3a10b492363154fd6e34b75fc2e0::miku {
    struct MIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKU>(arg0, 6, b"MIKU", b"MIku Coin", b"MIKU token, a cryptocurrency project that is inspired by Hatsune Miku, a popular virtual singer and a character created by Crypton Future Media.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigj4ae4fb5erx3kwd7l5wxu77524dxmth46xjctt5ilt5lwu7tyy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

