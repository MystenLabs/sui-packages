module 0x4e36ba46db5767172126bd29618744f974ac7f7554e50456904077f2c8f2a832::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"Hop Cat", b"HOPCAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbyoV2waeruJkBGp4niEkgNnD2WGgDqjpgGgWK8dLU2RH")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPCAT>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPCAT>(12730742859870759553, v0, v1, 0x1::string::utf8(b"https://x.com/HopCatSui"), 0x1::string::utf8(b"https://hopcat.fun/"), 0x1::string::utf8(b"https://t.me/HopCatSui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

