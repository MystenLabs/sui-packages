module 0xfee2a5026040e62b245f0be05988bf2b95370746d132c0afedec4be4bb77579a::sgoat {
    struct SGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOAT>(arg0, 6, b"sGOAT", b"Sonic Goat", b"We're not here for a slow graze in the crypto pasture; we're a full-on stampede towards financial freedom. Backed by the biggest SUI whale, sGOAT offers a chance to break the chains of fiat and join the meme coin revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sonic_f473b72f1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

