module 0x25c8be20d126c60f41fc6a978e22f13c67a96d96f28a794c0d1a8185e357082a::HARRYPOTTEROBAMASONICSIU {
    struct HARRYPOTTEROBAMASONICSIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRYPOTTEROBAMASONICSIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRYPOTTEROBAMASONICSIU>(arg0, 6, b"HARRYPOTTEROBAMASONICSIU", b"HARRYPOTTEROBAMASONICSIU", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ClNfMPT.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HARRYPOTTEROBAMASONICSIU>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRYPOTTEROBAMASONICSIU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRYPOTTEROBAMASONICSIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

