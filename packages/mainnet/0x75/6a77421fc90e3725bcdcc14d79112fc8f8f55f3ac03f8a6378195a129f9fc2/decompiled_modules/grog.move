module 0x756a77421fc90e3725bcdcc14d79112fc8f8f55f3ac03f8a6378195a129f9fc2::grog {
    struct GROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROG>(arg0, 6, b"Grog", b"GroGro", b"Just a meme coin, Now web page. No telegram, No twitter, Just a meme cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie4qlqrynkfliyquoug2ndzq6nissj5cm4mqlzwrnpmpvqmf74uby")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GROG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

