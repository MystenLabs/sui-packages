module 0xced4c3dea07f9a092f41108a5f0beb3dd3e5f47202917ba098e791d23283d786::lenny {
    struct LENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENNY>(arg0, 9, b"Lenny", b"Lenny", b"The many faces of Lenny | Website: https://lennysolana.xyz/ | Telegram: https://t.me/lennyonsola | Created on: https://pump.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf-ipfs.com/ipfs/QmcT3AjJ4wxR21RoBjmDL8q3Pjwq47bMZibpLYjZEDxuXV")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LENNY>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

