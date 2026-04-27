module 0x9e278ca160510dc1556d04eaa0b5bb5ef41e10111f74e685159eb98ce4bd2351::create_token_workshop {
    struct CREATE_TOKEN_WORKSHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATE_TOKEN_WORKSHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATE_TOKEN_WORKSHOP>(arg0, 6, b"Au", b"Goldman", b"playing around with tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/georgegoldman/image/upload/v1775824438/github_profile_compressed_tstbqw.jpg"))), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = mint_goldman(v3, 10000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATE_TOKEN_WORKSHOP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<CREATE_TOKEN_WORKSHOP>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREATE_TOKEN_WORKSHOP>>(v1);
    }

    fun mint_goldman(arg0: &mut 0x2::coin::TreasuryCap<CREATE_TOKEN_WORKSHOP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CREATE_TOKEN_WORKSHOP> {
        0x2::coin::mint<CREATE_TOKEN_WORKSHOP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

