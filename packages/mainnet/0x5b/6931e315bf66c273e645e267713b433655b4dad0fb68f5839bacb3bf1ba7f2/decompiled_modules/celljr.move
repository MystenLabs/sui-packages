module 0x5b6931e315bf66c273e645e267713b433655b4dad0fb68f5839bacb3bf1ba7f2::celljr {
    struct CELLJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELLJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CELLJR>(arg0, 6, b"CELLJR", b"Cell Jr.", b"Cell Juniors are curious, mischievous and playful, but they also like to hurt others, toy with their opponents and even get them into fights. They come to play in the SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicwrd7vjmgv2myjwqajqmiujb5dgarskfx6f3lw5zd4vpwx4gspji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELLJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CELLJR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

