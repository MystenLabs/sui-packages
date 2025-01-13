module 0x1d4abd11904d78ce9a3e6949571bbcbded2f62cdcf43997213f898a02fdc516::com {
    struct COM has drop {
        dummy_field: bool,
    }

    fun init(arg0: COM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COM>(arg0, 9, b"COM", b"com", b"com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreic5rvww44r365h66omnrhxft5fsz7v4cliq45xbiv4d4g7isbl7sm?X-Algorithm=PINATA1&X-Date=1736745541&X-Expires=315360000&X-Method=GET&X-Signature=b687f80f67dfe1709a172e4fb11750c1e8cda25db85045a9a1ab410dda0da349"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COM>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COM>>(v2);
    }

    // decompiled from Move bytecode v6
}

