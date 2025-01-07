module 0xb53634aa1a740d9eb14caad6dedacbaa861f271ebb3e74e17fe905a3df814d42::ston {
    struct STON has drop {
        dummy_field: bool,
    }

    fun init(arg0: STON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STON>(arg0, 9, b"STON", b"SuiTon", b"Just Meme Coins , https://suiandton.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/172283417?s=400&u=bbbd473bd600c173449de2091c63e9512b9c3096&v=4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STON>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STON>>(v1);
    }

    // decompiled from Move bytecode v6
}

