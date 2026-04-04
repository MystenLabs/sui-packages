module 0x7555be68cba17d64444f1321155eba8e30d217816e69b63653a3d20ee28167ac::funnycat {
    struct FUNNYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775262802919-a08a92facd743e20534f24e61894d5e8.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775262802919-a08a92facd743e20534f24e61894d5e8.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<FUNNYCAT>(arg0, 9, b"FUNNYCAT", b"Funny CAT", x"46756e6e792063617420f09f9885f09f9882", v1, arg1);
        let v4 = v2;
        if (10000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<FUNNYCAT>(&mut v4, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNYCAT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUNNYCAT>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

